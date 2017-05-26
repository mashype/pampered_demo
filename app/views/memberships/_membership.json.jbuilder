json.extract! membership, :id, :total_credits, :used_credits, :email, :card_token, :user_id, :created_at, :updated_at
json.url membership_url(membership, format: :json)