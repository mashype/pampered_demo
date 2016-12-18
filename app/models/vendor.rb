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


  # This directive enables Filterrific for the Student class.
  # We define a default sorting by most recent sign up, and then
  # we make a number of filters available through Filterrific.
  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_vendor_type_id,
      :with_created_at_gte
    ]
  )

	scope :search_query, lambda { |query|

	  return nil  if query.blank?
	  terms = query.downcase.split(/\s+/)

	  terms = terms.map { |e|
	    (e.gsub('*', '%') + '%').gsub(/%+/, '%')
	  }

	  num_or_conds = 2
	  where(
	    terms.map { |term|
	      "(LOWER(vendors.name) LIKE ? OR LOWER(vendors.bio) LIKE ?)"
	    }.join(' AND '),
	    *terms.map { |e| [e] * num_or_conds }.flatten
	  )
	}

	scope :sorted_by, lambda { |sort_option|

  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
	  case sort_option.to_s
	  when /^created_at_/
	    order("vendors.created_at #{ direction }")
	  when /^name_/
	    order("LOWER(vendors.name) #{ direction }, LOWER(students.bio) #{ direction }")
	  when /^vendor_type_title_/
	    order("LOWER(vnedor_types.title) #{ direction }").includes(:vendor_type)
	  else
	    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
	  end
	}
	
	scope :with_vendor_type_id, lambda { |vendor_type_ids|
	  where(with_vendor_type_id: [*vendor_type_ids])
	}
  
	scope :created_at_gte, lambda { |reference_time|
	  where('vendors.created_at >= ?', reference_time)
	}


  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Registration date (newest first)', 'created_at_desc'],
      ['Registration date (oldest first)', 'created_at_asc'],
      ['Type(a-z)', 'vendor_type_id_asc']
    ]
  end

end

