class ChangeCostIdToAmount < ActiveRecord::Migration
  def change
  	rename_column :appointments, :cost_id, :amount_id
  end
end
