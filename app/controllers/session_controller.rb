require 'net/http'
require 'json'
class SessionController < ApplicationController
  #skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
    puts "creating session..."
  	@admin = Admin.find_by(username: params[:username])
  	if @admin && @admin.authenticate(params[:password])
      session[:admin_id] = @admin.id
      redirect_to '/welcome'
      respond_to do |format|
        format.html
        format.json { render json: @admin }
      end
  	else
      redirect_to '/login'
  	end
  end

  def logout
    print("logging out?")
  	session[:admin_id] = nil
  	redirect_to '/welcome'
  end

  def login
    print("login?")
  end

  def welcome
    print("welcome?")
    if logged_in?
      redirect_to '/meditations'
    # else
    #   redirect_to '/session/create'
    end
  	respond_to do |format|
        format.html
        format.json { render json: @admin }
    end
  end

  def page_requires_login
  end
end