class AddUserIdToAppointments < ActiveRecord::Migration
  def change
  	add_column :appointments, :user_id, :integer
  	add_column :appointments, :service_id, :integer
  end
end
