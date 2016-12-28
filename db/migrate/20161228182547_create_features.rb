class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.belongs_to :vendor_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
