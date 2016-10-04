class Service < ActiveRecord::Base
	has_many :appointments

	has_many :vendor_services
	has_many :vendors, through: :vendor_services

end

