class AdminsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  
  def new
  	@admin = Admin.new
  end

  def create
   permitted_admins = ["stephanie.schuette@duke.edu"]
   if params[:admin][:username].in?(permitted_admins)
     @admin = Admin.create(params.require(:admin).permit(:username,        
     :password))
     session[:admin_id] = @admin.id
     redirect_to '/meditations/'
   else
    puts "NOT PERMITTED"
     redirect_to '/welcome'
   end
  end
end
