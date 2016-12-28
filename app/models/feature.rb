class Feature < ActiveRecord::Base
	belongs_to :vendor_type

	has_many :vendor_features
	has_many :vendors, through: :vendor_features

end

