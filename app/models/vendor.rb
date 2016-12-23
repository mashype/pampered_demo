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


	filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
            	:available_filters => %w[
                sorted_by
                search_query
                with_user_id
                with_vendor_type_id
                with_created_at_gte
              ]

  	# default for will_paginate
  	self.per_page = 10


	scope :search_query, lambda { |query|
	    return nil  if query.blank?
	    # condition query, parse into individual keywords
	    terms = query.downcase.split(/\s+/)
	    # replace "*" with "%" for wildcard searches,
	    # append '%', remove duplicate '%'s
	    terms = terms.map { |e|
	      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
	    }
	    # configure number of OR conditions for provision
	    # of interpolation arguments. Adjust this if you
	    # change the number of OR conditions.
	    num_or_conditions = 3
	    where(
	      terms.map {
	        or_clauses = [
	          "LOWER(vendors.name) LIKE ?",
	          "LOWER(vendors.bio) LIKE ?",
	          "LOWER(vendors.sm_twitter) LIKE ?"
	        ].join(' OR ')
	        "(#{ or_clauses })"
	      }.join(' AND '),
	      *terms.map { |e| [e] * num_or_conditions }.flatten
	    )
	}

  	scope :sorted_by, lambda { |sort_option|
    	# extract the sort direction from the param value.
    	direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    	case sort_option.to_s
    	when /^created_at_/
     		order("vendors.created_at #{ direction }")
    	when /^title_/
    		order("LOWER(vendors.name) #{ direction }, LOWER(vendors.bio) #{ direction }")
    	when /^vendor_type_title_/
    		order("LOWER(vendor_types.title) #{ direction }").includes(:vendor_type)
    else
      	raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  	scope :with_user_id, lambda { |user_ids| where(:user_id => [*user_ids]) }

  	scope :with_vendor_type_id, lambda { |vendor_type_ids| where(:vendor_type_id => [*vendor_type_ids]) }

  	scope :with_created_at_gte, lambda { |ref_date| where('vendors.created_at >= ?', ref_date) }

	delegate :title, :to => :vendor_type, :prefix => true

	def self.options_for_sorted_by
	    [
	      ['Title (a-z)', 'title_asc'],
	      ['Registration date (newest first)', 'created_at_desc'],
	      ['Registration date (oldest first)', 'created_at_asc'],
	      ['type (a-z)', 'vendor_type_title_asc']
	    ]
	end


	def slug
   		name.downcase.gsub(" ", "-")
  	end

 	def to_param
    	"#{id}-#{slug}"
   	end

end

