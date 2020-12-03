class CreateStakes < ActiveRecord::Migration[6.0]
  def change
    create_table :stakes do |t|
      t.integer :user_id
      t.integer :checkpoint_id
      t.integer :sum
      t.integer :type
      t.boolean :success
      t.boolean :closed

      t.timestamps
    end
  end
end
