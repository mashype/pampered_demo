class CreateVendorDocuments < ActiveRecord::Migration
  def change
    create_table :vendor_documents do |t|
      t.string :name
      t.belongs_to :vendor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
