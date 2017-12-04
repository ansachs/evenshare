class SessionsController < Devise::SessionsController
  before_action :store_referrer, only: [:new]

  private

  def store_referrer
    session[:referrer] = request.referrer
  end

  
end