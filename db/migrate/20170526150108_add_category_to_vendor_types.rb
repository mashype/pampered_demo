class AddCategoryToVendorTypes < ActiveRecord::Migration
  def change
    add_column :vendor_types, :category, :string
  end
end
