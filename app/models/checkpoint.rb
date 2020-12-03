class Checkpoint < ApplicationRecord
  has_many :tries
  has_many :stakes
end
