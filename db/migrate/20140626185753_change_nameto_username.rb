class ChangeNametoUsername < ActiveRecord::Migration
  def change
    change_column :users, :name, :username
  end
end
