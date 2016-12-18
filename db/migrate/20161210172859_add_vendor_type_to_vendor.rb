class AddVendorTypeToVendor < ActiveRecord::Migration
  def change
  	add_column :vendors, :vendor_type_id, :integer
  end
end
