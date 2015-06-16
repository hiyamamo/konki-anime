module SessionsHelper
	def singed_in?
		!session[:user_id].nil?
	end
end
