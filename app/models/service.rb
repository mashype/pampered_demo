class Service < ActiveRecord::Base

	belongs_to :vendor_type
	has_many :appointments

	has_many :vendor_services
	has_many :vendors, through: :vendor_services


	def self.options_for_select
		order('LOWER(title)').map { |e| [e.title, e.id] }
	end


end
 
