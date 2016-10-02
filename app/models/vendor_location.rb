class VendorLocation < ActiveRecord::Base

	belongs_to :vendor
	belongs_to :location

	accepts_nested_attributes_for :location

end
