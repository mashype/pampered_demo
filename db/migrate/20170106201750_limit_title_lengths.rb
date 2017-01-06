class LimitTitleLengths < ActiveRecord::Migration
  def change
  	change_column :appointments, :title, :string, :limit => 50
  	change_column :vendors, :name, :string, :limit => 50
  end
end
