class SessionsController < ApplicationController
  def create
		auth = request.env["omniauth.auth"]
		user = User.find_by_uid_and_provider(auth["uid"], auth["provider"]) || User.create_with_auth(auth)
		session[:user_id] = user.id

		redirect_to root_url, :notice => "Sign in"
  end

	def destroy
		session[:user_id] = nil

		redirect_to root_url, :notice => "Sign out"
	end
end
