class Stake < ApplicationRecord
  belongs_to :user
  belongs_to :checkpoint
  belongs_to :participant

  enum stake_type: [ :failure, :success]

  def pretty_type
    return "на проеб" if failure?
    "на успех"
  end

  def self.print_type(option)
    return "проеб" if option == 0
    return "успех" if option == 1
  end

  scope :with_checkpoint_and_participant,
        -> (checkpoint_id, participant_id) { where(checkpoint_id: checkpoint_id, participant_id: participant_id) }

end
