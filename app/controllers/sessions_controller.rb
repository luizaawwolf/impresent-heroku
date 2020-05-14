require 'net/http'
require 'json'
class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
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
  	session[:admin_id] = nil
  	redirect_to '/welcome'
  end

  def login
  end

  def welcome
    if logged_in?
      redirect_to '/meditations'
    end
  	respond_to do |format|
        format.html
        format.json { render json: @admin }
    end
  end

  def page_requires_login
  end
end
