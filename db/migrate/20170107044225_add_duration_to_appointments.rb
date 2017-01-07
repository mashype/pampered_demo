class AddDurationToAppointments < ActiveRecord::Migration
  def change
    add_reference :appointments, :duration, index: true, foreign_key: true
  end
end
