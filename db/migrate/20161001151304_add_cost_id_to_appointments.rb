class AddCostIdToAppointments < ActiveRecord::Migration
  def change
  	add_column :appointments, :cost_id, :integer
  end
end
