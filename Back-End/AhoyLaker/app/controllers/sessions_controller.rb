class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.find_by_email(params[:session][:email])
		if @user && @user.authenticate(params[:session][:password])
			if @user.is_admin
				session[:user_id] = @user.id
				redirect_to '/organizations/'
			else
				session[:user_id] = @user.id
				redirect_to '/organizations/' + @user.organization_id.to_s + '/'
			end
		else
			redirect_to 'login'
		end 
	end

	def destroy
    	session[:user_id] = nil
    	redirect_to root_url
	end 

end
