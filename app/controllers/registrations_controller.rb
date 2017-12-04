class RegistrationsController < Devise::RegistrationsController
   after_action :store_location



  private
  def store_location
    binding.pry
  # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end
  def after_sign_in_path_for(resource)
    binding.pry
    session[:previous_url] || root_path
  end

  def after_sign_up_path_for(resource)
    signed_in_root_path(resource)
  end

  def sign_up_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end