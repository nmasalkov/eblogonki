class BonusAdder
  def initialize
    @users = User.all
  end

  def execute
    @users.each do |user|
      new_balance = user.points + 200
      ActiveRecord::Base.transaction do
        user.update!(points: new_balance)
        Log.create!(
          body: log_body(user, new_balance)
        )
      end
    end
  end

  def log_body(user, new_balance)
    "<span>#{fancy_time} </span><span>Игрок </span><span>#{user.name} </span><span>получает гарантированные </span> <span>200 </span>
<span>и теперь имеет </span> <span>#{new_balance}</span> "
  end

  def fancy_time
    Time.new.strftime("%d/%m/%g %R")
  end
end