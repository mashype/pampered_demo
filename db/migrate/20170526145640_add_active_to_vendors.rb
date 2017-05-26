class AddActiveToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :active, :boolean, null: false, default: true
  end
end
