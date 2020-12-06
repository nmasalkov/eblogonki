class Stake < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :checkpoint, optional: true
  belongs_to :participant, optional: true

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
