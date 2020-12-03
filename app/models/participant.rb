class Participant < ApplicationRecord
  has_many :tries
  has_many :stakes

  def position
    rand(8)
  end

end
