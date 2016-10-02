json.extract! booking, :id, :user_id, :appointment_id, :conf_temp, :email, :card_token, :created_at, :updated_at
json.url booking_url(booking, format: :json)