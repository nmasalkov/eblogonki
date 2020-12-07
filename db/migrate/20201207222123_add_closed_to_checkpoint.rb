class AddClosedToCheckpoint < ActiveRecord::Migration[6.0]
  def change
    add_column :checkpoints, :closed, :boolean, default: false
  end
end
