class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :stakes

  validate do |user|
   errors[:base] << "У вас недосаточно очков, милорд" if user.points < 0
  end

  # validates :points, :numericality => { :greater_than_or_equal_to => 0, message:  }

end
