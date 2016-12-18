class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.string :appointment_id
      t.string :conf_temp
      t.string :email
      t.string :card_token

      t.timestamps null: false
    end
  end
end
