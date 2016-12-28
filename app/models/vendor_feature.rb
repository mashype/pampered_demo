class VendorFeature < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :feature

end
