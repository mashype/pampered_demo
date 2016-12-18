class VendorType < ActiveRecord::Base
	has_many :vendors
	has_many :services

	def self.options_for_select
	  order('LOWER(title)').map { |e| [e.title, e.id] }
	end

end
