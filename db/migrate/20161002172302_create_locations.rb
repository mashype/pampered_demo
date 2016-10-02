class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :add_1
      t.string :add_2
      t.string :city
      t.string :state
      t.string :zip
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
