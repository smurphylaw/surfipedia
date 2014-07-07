class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.integer :plan_id
      t.string :email

      t.timestamps
    end
  end
end
