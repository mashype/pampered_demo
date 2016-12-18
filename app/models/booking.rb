class Booking < ActiveRecord::Base
	belongs_to :user
	belongs_to :appointment


	def process_payment token
    customer_id = user.stripe_customer
    if customer_id
      customer = Stripe::Customer.retrieve customer_id
    else
      customer = Stripe::Customer.create email: email, card: token
      user.update_attribute :stripe_customer, customer.id
    end

    Stripe::Charge.create \
      amount: appointment.amount.cost * 100, 
      customer: customer.id,
      description: appointment.title, 
      currency: 'usd'
  end  

end
