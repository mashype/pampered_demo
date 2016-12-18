class CreateVendorLicenses < ActiveRecord::Migration
  def change
    create_table :vendor_licenses do |t|
      t.string :licenser
      t.string :name
      t.string :issue_date
      t.string :license_number
      t.belongs_to :vendor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
