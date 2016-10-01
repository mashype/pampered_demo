class AddStripeToUser < ActiveRecord::Migration
  def change
  	add_column :users, :admin, :boolean, :default => false
  	add_column :users, :stripe_customer, :text  	
  end
end
