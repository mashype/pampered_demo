class UserMailer < ApplicationMailer
	default from: "seth@pamperedup.com"

  def registration_confirmation(user)
    @profile = profile

    mail (to: profile.user.email, subject: "Sign Up Confirmation")
  end

end