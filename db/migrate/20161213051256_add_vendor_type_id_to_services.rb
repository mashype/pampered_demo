class AddVendorTypeIdToServices < ActiveRecord::Migration
  def change
  	add_column :services, :vendor_type_id, :integer
  end
end
