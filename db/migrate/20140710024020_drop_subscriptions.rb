class DropSubscriptions < ActiveRecord::Migration
  def up
    drop_table :subscriptions
  end

  def down
    create_table :subscriptions do |t|
      t.references :plan
      t.references :user

      t.timestamps
    end
    add_index :subscriptions, :plan_id
    add_index :subscriptions, :user_id
  end   
end
