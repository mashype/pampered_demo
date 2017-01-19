class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :prepare_meta_tags, if: "request.get?"
	before_action :set_coords

  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end

  def lookup_ip_location
		Geocoder.search(request.remote_ip).first
	end 

	def set_coords
		if session[:latitude].nil?
			coords = lookup_ip_location
			session[:latitude] = coords.latitude
			session[:longitude] = coords.longitude
		end
	end	

  def prepare_meta_tags(options={})
    site_name   = "Pampered Up"
    title       = [controller_name, action_name].join(" ")
    description = "You don't have to be ridiculously rich to get a little pampering.  Bring private masseurs, chefs and stylists into your home for top notch treatment today!"
    image       = options[:image] || "your-default-image-url"
    current_url = request.url

    # Let's prepare a nice set of defaults
    defaults = {
      site:        "PamperedUp",
      title:       "You deserve it",
      description: "You don't have to be ridiculously rich to get a little pampering.",
      keywords:    "massage hair stylist private chef housekeeping pampering pamper pamperedup yoga health fitness mani manicure pedi pedicure",
      twitter: {
        site_name: "PamperedUp",
        site: '@getyourpamp',
        card: 'summary',
        description: 'Pampered Twitter page',
        image: image
      }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end
  
end
