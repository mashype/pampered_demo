json.extract! location, :id, :add_1, :add_2, :city, :state, :zip, :latitude, :longitude, :created_at, :updated_at
json.url location_url(location, format: :json)