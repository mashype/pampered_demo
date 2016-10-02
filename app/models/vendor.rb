class Vendor < ActiveRecord::Base

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

	belongs_to :user
	has_many :appointments

	has_many :vendor_locations
	has_many :locations, through: :vendor_locations
	accepts_nested_attributes_for :vendor_locations, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :locations, reject_if: :all_blank, allow_destroy: true
end
