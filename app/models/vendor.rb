class Vendor < ActiveRecord::Base

 	has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#" }, 
	:default_url => "https://s3.amazonaws.com/fitchike-dev/profiles/avatars/missing_:style.jpg"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	belongs_to :user
	belongs_to :vendor_type
	has_many :appointments
	has_many :reviews

	has_many :vendor_locations
	has_many :locations, through: :vendor_locations
	accepts_nested_attributes_for :vendor_locations, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :locations, reject_if: :all_blank, allow_destroy: true


	has_many :vendor_services
	has_many :services, through: :vendor_services
	accepts_nested_attributes_for :vendor_services, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :services, reject_if: :all_blank, allow_destroy: true

	has_many :vendor_licenses
	accepts_nested_attributes_for :vendor_licenses, reject_if: :all_blank, allow_destroy: true



	def slug
   		name.downcase.gsub(" ", "-")
  	end

 	def to_param
    	"#{id}-#{slug}"
   	end

end

