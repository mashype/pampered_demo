class BookingMailer < ApplicationMailer

  default :from => "seth@pamperedup.com"

  def booking_confirmation(booking)
  	@user = booking.user
  	attachments["pampered_header.png"] = File.read("#{Rails.root}/public/images/pampered_header.png")
	mail(:to => "#{booking.user.username} <#{booking.user.email}>", :subject => "You're Booked!")
  end

  def vendor_confirmation(booking)
  	@user = booking.appointment.vendor.user
	mail(:to => booking.appointment.vendor.user.email, :subject => "You've Been Booked!")
  end

  def admin_confirmation(booking)
	mail(:to => 'seth@pamperedup.com', :subject => "Someone actually used it!")
  end  
  
  def registration_confirmation(user)
    @user = user
    attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
end