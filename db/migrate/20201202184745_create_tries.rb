class CreateTries < ActiveRecord::Migration[6.0]
  def change
    create_table :tries do |t|
      t.boolean :success
      t.datetime :pass_time
      t.integer :participant_id
      t.integer :checkpoint_id

      t.timestamps
    end
  end
end
