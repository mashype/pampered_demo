class AddActiveToAppointments < ActiveRecord::Migration
  def change
  	add_column :appointments, :active, :boolean, null: false, default: true
  end
end
