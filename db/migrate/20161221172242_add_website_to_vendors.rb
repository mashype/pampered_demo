class AddWebsiteToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :website, :string, :limit => 200
  end
end
