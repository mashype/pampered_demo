class AddSocialMediaFieldsToVendor < ActiveRecord::Migration
  def change
  	add_column :vendors, :sm_facebook, :string
  	add_column :vendors, :sm_twitter, :string
  	add_column :vendors, :sm_instagram, :string
  	add_column :vendors, :sm_pinterest, :string  	
  end
end
