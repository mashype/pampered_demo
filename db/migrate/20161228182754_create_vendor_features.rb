class CreateVendorFeatures < ActiveRecord::Migration
  def change
    create_table :vendor_features do |t|
      t.belongs_to :vendor, index: true, foreign_key: true
      t.belongs_to :feature, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
