class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code_string, null: false
      t.integer :min_price, default: 0 
      t.integer :max_price, default: 1000
      t.integer :min_value, default: 0
      t.integer :max_value, default: 100
      t.decimal :disc_pct, precision: 3, scale: 2, default: 0
      t.integer :disc_cost, default: 0
      t.date :exp_date, null: false

      t.timestamps null: false
    end
  end
end
