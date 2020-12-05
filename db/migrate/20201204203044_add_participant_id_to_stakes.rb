class AddParticipantIdToStakes < ActiveRecord::Migration[6.0]
  def change
    add_column :stakes, :participant_id, :integer
  end
end
