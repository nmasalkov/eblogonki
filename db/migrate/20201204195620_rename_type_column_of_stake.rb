class RenameTypeColumnOfStake < ActiveRecord::Migration[6.0]
  def change
    rename_column :stakes, :type, :stake_type
  end
end
