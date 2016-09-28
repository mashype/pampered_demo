class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title
      t.text :desctiption

      t.timestamps null: false
    end
  end
end
