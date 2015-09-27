class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :boolean, default: false
    add_column :users, :daysGold, :integer, default: 0
  end
end
