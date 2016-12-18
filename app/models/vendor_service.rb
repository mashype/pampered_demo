class VendorService < ActiveRecord::Base

	belongs_to :vendor
	belongs_to :service

	accepts_nested_attributes_for :service

end
