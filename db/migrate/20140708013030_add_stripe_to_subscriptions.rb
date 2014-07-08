class AddStripeToSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :stripe_customer_token, :string
  end
end
