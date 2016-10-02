class Appointment < ActiveRecord::Base
	belongs_to :service
	belongs_to :amount
	belongs_to :vendor

	has_many :bookings

end

 