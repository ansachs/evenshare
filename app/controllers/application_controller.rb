class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
    def after_sign_in_path_for(resource)
      binding.pry
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    end
end
