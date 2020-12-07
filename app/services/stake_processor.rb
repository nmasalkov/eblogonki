class StakeProcessor

  def initialize(stake, status)
    @stake = stake
    @status = status
    @user = @stake.user
    @participant= @stake.participant
  end

  def call
    if stake_won?
      calculate_win
    else
      calculate_loose
    end
  end

  def calculate_win
    if @stake.success?
      @prize = @stake.sum * 2
    else
      @prize = @stake.sum * 4
    end

    ActiveRecord::Base.transaction do
      @new_points = @user.points += @prize
      @user.update!(points: @new_points)

      Log.create!(body: win_log, user_id: @user.id)
    end
  end

  def calculate_loose
    Log.create!(body: loose_log, user_id: @user.id)
  end

  def stake_won?
    @stake.stake_type == @status
  end

  def win_log
    "<span>#{fancy_time} </span><span>Ставка #{@user.name} </spam><span>#{@stake.pretty_type} </span><span>#{@participant.name} </span>
<span>в #{@stake.checkpoint.name} сыграла!!! </span><span>Выигрыш составил </span><span>#{@prize}</span>"
  end

  def loose_log
    "<span>#{fancy_time} </span><span>Ставка #{@user.name} </spam><span>#{@stake.pretty_type} </span><span>#{@participant.name} </span>
<span>в #{@stake.checkpoint.name} не сыграла!!! </span><span>Проигрыш составил </span><span>#{@stake.sum}</span>"
  end

  def fancy_time
    Time.new.strftime("%d/%m/%g %R")
  end
end
