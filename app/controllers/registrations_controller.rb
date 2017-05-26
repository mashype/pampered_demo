class RegistrationsController < Devise::RegistrationsController
  protected


  def after_sign_up_path_for(resource)
    welcome_membership_path
  end

  private
	  def sign_up_params
	    params.require(:user).permit(:username, :email, :avatar, :gender_id, :bio, :password, :password_confirmation)
	  end

	  def account_update_params
	    params.require(:user).permit(:username, :email, :avatar, :gender_id, :bio, :password, :password_confirmation, :current_password)
	  end
end


