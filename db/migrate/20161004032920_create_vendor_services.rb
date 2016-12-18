class CreateVendorServices < ActiveRecord::Migration
  def change
    create_table :vendor_services do |t|
      t.integer :vendor_id
      t.integer :service_id
      t.string :notes

      t.timestamps null: false
    end
  end
end
