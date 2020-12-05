class AddScheduledDateToCheckpoint < ActiveRecord::Migration[6.0]
  def change
    add_column :checkpoints, :scheduled_date, :datetime
  end
end
