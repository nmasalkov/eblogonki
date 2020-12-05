class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :stakes

  attr_writer :login


  validates :name, :presence => true, :uniqueness => true

  validate do |user|
   errors[:base] << "У вас недосаточно очков, милорд" if user.points < 0
  end

  def login
    @login || self.name
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(name) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  # validates :points, :numericality => { :greater_than_or_equal_to => 0, message:  }

end
