class ApplicationController < ActionController::Base
	#before_action :authorized
	helper_method :current_admin
	helper_method :logged_in?

	def current_admin
		puts "checking admin"
		puts session


		create_session


		puts Admin.find_by(id: session[:admin_id])
		puts session[:admin_id]
		Admin.find_by(id: session[:admin_id])
	end

	def create_session
	    puts "creating session..."
	  	@admin = Admin.find_by(username: params[:username])
	  	if @admin && @admin.authenticate(params[:password])
	      session[:admin_id] = @admin.id
	  	else
	      session[:admin_id] = nil
	  	end
  	end

	def logged_in?  
    	!current_admin.nil?  
	end

	def authorized
		redirect_to '/welcome' unless logged_in?
	end
end
