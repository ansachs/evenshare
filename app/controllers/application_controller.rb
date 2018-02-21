class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
    def after_sign_in_path_for(resource)
      session[:referrer]
    end

    def authenticate_user!
      if user_signed_in?
        super
      else

        # redirect_to action: 'index', status: 200, alert: "Watch it, mister!" 
        flash[:notice] = "test"
        redirect_to "/concerts/#{params[:concert_id]}/shared_experiences"
        # 
        # flash[:error] = "My flash message error."

        # respond_to do |format|
        #   format.js 
        # end



        # binding.pry
        # return redirect_to concert_shared_experiences_url
        # flash[:notice] = "must login"
      end
    end
end
