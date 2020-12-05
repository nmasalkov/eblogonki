class StakeCreator

  attr_accessor :success
  attr_accessor :errors

  def initialize(params, user)
    @errors = []
    @params = params
    detect_type(params["commit"])
    @attrs = @params.permit("checkpoint_id", "sum", "stake_type", "user_id", "participant_id")
    @user = User.find(user.id)
  end

  def save
    ActiveRecord::Base.transaction do
      if existing_stake
        existing_stake.update!(sum: existing_stake.sum + @params["sum"].to_i)
      else
        Stake.create!(@attrs)
      end
      @user.update!(points: @user.points - @attrs["sum"].to_i)
      participant = Participant.find(@attrs["participant_id"])
      log_body =
          "#{fancy_time} #{@user.name} поставил #{@attrs["sum"]} на #{fancy_stake_type} #{participant.name} в #{fancy_checkpoint}"
      Log.create(body: log_body)
    end
    @success = true
  rescue => e
    @errors << e.message
    @success = false
  end

  def fancy_stake_type
    Stake.print_type(@attrs[:stake_type])
  end

  def fancy_time
    Time.new.strftime("%d/%m/%g %R")
  end

  def fancy_checkpoint
    Checkpoint.find(@attrs["checkpoint_id"]).name
  end

  def existing_stake
    Stake.where(checkpoint_id: @attrs["checkpoint_id"], user_id: @user.id, stake_type: @params[:stake_type]).first
  end

  def detect_type(commit)
    case commit
    when "на проёб"
      @params["commit"] = 0
    when "на успех"
      @params["commit"] = 1
    else
      raise "Этой ошибки никогда не будет"
    end
    @params[:stake_type] = @params.delete "commit"
  end

end