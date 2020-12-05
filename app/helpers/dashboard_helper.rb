module DashboardHelper
  def any_stake?(checkpoint, participant)
    Stake.with_checkpoint_and_participant(checkpoint.id, participant.id).any?
  end

  def stakes_for_checkpoint(checkpoint, participant)
    Stake.with_checkpoint_and_participant(checkpoint.id, participant.id)
  end
end
