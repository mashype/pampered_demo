class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.integer :user_id
      t.string :name
      t.text :bio

      t.timestamps null: false
    end
  end
end
