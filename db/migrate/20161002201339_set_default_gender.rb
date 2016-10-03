class SetDefaultGender < ActiveRecord::Migration
  def change
  	change_column :users, :gender_id, :integer, :default => 3
  end
end
