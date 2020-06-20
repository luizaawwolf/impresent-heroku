class AdminsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  
  def new
  	@admin = Admin.new
  end

  def create
   permitted_admins = ["stephanie.schuette@duke.edu","app"]
   @admin = Admin.find_by_username(params[:admin][:username])
   if params[:admin][:username].in?(permitted_admins) && @admin==nil
     @admin = Admin.create(params.require(:admin).permit(:username,        
     :password))
     session[:admin_id] = @admin.id
     redirect_to '/meditations/'
   else
     redirect_to '/welcome'
   end
  end
end