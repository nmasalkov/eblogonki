class AddDefaultPointsToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :points, 200
  end
end
