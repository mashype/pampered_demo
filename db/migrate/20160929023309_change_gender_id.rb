class ChangeGenderId < ActiveRecord::Migration
  def change
  	rename_column :users, :gender, :gender_id
  end
end
