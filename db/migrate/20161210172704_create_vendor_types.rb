class CreateVendorTypes < ActiveRecord::Migration
  def change
    create_table :vendor_types do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
