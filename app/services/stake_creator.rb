class StakeCreator

  attr_accessor :success
  attr_accessor :errors

  def initialize(params, user)
    @errors = []
    @params = params
    detect_type(params["commit"])
    @attrs = @params.permit("checkpoint_id", "sum", "stake_type", "user_id", "participant_id")
    @stake_sum = @attrs[:sum].to_i
    @user = User.find(user.id)
    @initial_points = @user.points
    @stake = existing_stake
    @initial_sum = @stake.sum if @stake
  end

  def save
    if !validate_sum
      raise "соси бибас, штраф тебе"
    end
    set_new_values
    ActiveRecord::Base.transaction do
      if @stake
        @stake.update!(sum: @new_stake_sum)
      else
        Stake.create!(@attrs)
      end
      @user.update!(points: @new_points)
      participant = Participant.find(@attrs["participant_id"])
      log_body =
          "<span>#{fancy_time}</span> <span>#{@user.name}</span> <span>поставил #{@stake_sum}</span> <span>на #{fancy_stake_type}</span> <span>#{participant.name}</span> <span>на #{fancy_checkpoint}</span>"
      log_user_id = @user.id
      Log.create(body: log_body, user_id: log_user_id)
    end
    @success = true
  rescue => e
    @errors << e.message
    @success = false
  end

  def set_new_values
    @new_points = @initial_points - @stake_sum
    @new_stake_sum = @stake.sum += @stake_sum if @stake
  end

  def validate_sum
    @params[:sum].to_i.positive?
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
    Stake.where(checkpoint_id: @attrs["checkpoint_id"],
                user_id: @user.id,
                participant_id: @attrs[:participant_id],
                stake_type: @params[:stake_type]).first
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