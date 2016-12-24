class Appointment < ActiveRecord::Base

	searchkick

	belongs_to :service
	belongs_to :amount
	belongs_to :vendor

	has_many :bookings



	filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
		:available_filters => %w[
			sorted_by
            search_query
            with_service_id
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
		num_or_conditions = 2
		where(
		  terms.map {
		    or_clauses = [
		      "LOWER(appointments.title) LIKE ?",
		      "LOWER(appointments.description) LIKE ?"
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
    		order("appointments.created_at #{ direction }")
    	when /^name_/
    		order("LOWER(appointments.title) #{ direction }, LOWER(appointments.description) #{ direction }")
    	when /^country_name_/
      		order("LOWER(services.title) #{ direction }").includes(:service)
    	else
      		raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    	end
  	}

  	scope :with_service_id, lambda { |service_ids| where(:service_id => [*service_ids]) }

  	scope :with_created_at_gte, lambda { |ref_date| where('appointments.created_at >= ?', ref_date) }

  	delegate :title, :to => :service, :prefix => true

  	def self.options_for_sorted_by
    	[
      		['Name (a-z)', 'name_asc'],
      		['Registration date (newest first)', 'created_at_desc'],
      		['Registration date (oldest first)', 'created_at_asc'],
      		['Service (a-z)', 'service_title_asc']
    	]
  	end



	def slug
   		title.downcase.gsub(" ", "-")
  	end

 	def to_param
    	"#{id}-#{slug}"
  	end

end

  