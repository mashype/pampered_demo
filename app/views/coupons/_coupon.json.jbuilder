json.extract! coupon, :id, :code_string, :min_price, :max_price, :min_value, :max_value, :disc_pct, :disc_cost, :exp_date, :created_at, :updated_at
json.url coupon_url(coupon, format: :json)