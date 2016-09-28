class WelcomeController < ApplicationController

	def index
		set_meta_tags title: "Your private concierge",
							keywords: "massage stylist hair nails",
							description: "Fitness made social, get started today"
	end

end
