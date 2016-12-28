class VendorType < ActiveRecord::Base
	has_many :vendors
	has_many :services
	has_many :features

  	def self.options_for_select
    	order('LOWER(title)').map { |e| [e.title, e.id] }
  	end
end
