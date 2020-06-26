class ApplicationController < ActionController::Base
	#before_action :authorized
	helper_method :current_admin
	helper_method :logged_in?
	helper_method :authorized
	helper_method :create_session

	def current_admin
		puts "curr admin"
		Admin.find_by(id: session[:admin_id])
	end

	def logged_in?  
		puts "logged in?"
    	!current_admin.nil?  
	end

	def authorized
		puts "checking authorized"
		redirect_to '/welcome' unless logged_in?
	end

	def create_session
	    puts "creating session from app"
	  	@admin = Admin.find_by(username: params[:username])
	  	puts @admin
	  	puts params[:username]
	  	if @admin && @admin.authenticate(params[:password])
	      session[:admin_id] = @admin.id
	  	else
	  	  redirect_to '/welcome'
	  	end
  	end
end
