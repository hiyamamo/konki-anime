class SessionsController < ApplicationController
  def create
		auth = request.env["omniauth.auth"]
		user = User.find_by_uid_and_provider(auth["uid"], auth["provider"])
		if user
			user.update_access_token(auth)
		else
			User.create_with_auth(auth)
		end

		sign_in user
		redirect_to root_url, :notice => "Sign in"
  end

	def destroy
		sign_out
		redirect_to root_url, :notice => "Sign out"
	end
end
