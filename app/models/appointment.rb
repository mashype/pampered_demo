class Appointment < ActiveRecord::Base
	belongs_to :service
	belongs_to :amount
	belongs_to :vendor

	has_many :bookings

	def slug
    title.downcase.gsub(" ", "-")
  end

  def to_param
    "#{id}-#{slug}"
  end

end

 