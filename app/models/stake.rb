class Stake < ApplicationRecord
  belongs_to :user
  belongs_to :checkpoint
  belongs_to :participant
end
