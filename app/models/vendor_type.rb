class VendorType < ActiveRecord::Base
	has_many :vendors
	has_many :services
end
