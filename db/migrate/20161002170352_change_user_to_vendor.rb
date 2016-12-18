class ChangeUserToVendor < ActiveRecord::Migration
  def change
  	rename_column :appointments, :user_id, :vendor_id
  end
end
