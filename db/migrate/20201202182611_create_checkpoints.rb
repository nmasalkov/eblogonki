class CreateCheckpoints < ActiveRecord::Migration[6.0]
  def change
    create_table :checkpoints do |t|
      t.integer :order, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
