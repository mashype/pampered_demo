class Location < ActiveRecord::Base

	geocoded_by :address

	def address
	  [add_1, city, state, zip].compact.join(', ')
	end

	after_validation :geocode, :if => :add_1_changed? || :zip_changed? || :city_changed?

	has_many :vendor_locations
	has_many :vendors, through: :vendor_locations


end
