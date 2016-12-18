class CreateVendorLocations < ActiveRecord::Migration
  def change
    create_table :vendor_locations do |t|
      t.integer :vendor_id
      t.integer :location_id
      t.string :notes

      t.timestamps null: false
    end
  end
end
