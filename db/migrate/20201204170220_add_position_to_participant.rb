class AddPositionToParticipant < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :position, :integer
  end
end
