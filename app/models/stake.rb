class Stake < ApplicationRecord
  belongs_to :user
  belongs_to :checkpoint
  belongs_to :participant

  enum stake_type: [ :failure, :success]

  def pretty_type
    return "на проеб" if failure?
    "на успех"
  end

  scope :with_checkpoint_and_participant,
        -> (checkpoint_id, participant_id) { where(checkpoint_id: checkpoint_id, participant_id: participant_id) }

end
