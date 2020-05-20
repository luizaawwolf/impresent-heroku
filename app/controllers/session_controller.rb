require 'net/http'
require 'json'
class SessionController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
  	@admin = Admin.find_by(username: params[:username])
    puts "in create"
  	if @admin && @admin.authenticate(params[:password])
      session[:admin_id] = @admin.id
      respond_to do |format|
        puts "MEDS: #{@meditations}"
        puts "logged #{logged_in?}"
        format.html { redirect_to '/welcome'}
        #format.json { redirect_to '/welcome'}
        format.json { render json: @meditations }
      end
  	else
      respond_to do |format|
        format.html { redirect_to '/login'}
        format.json { render json: 404 }
      end
  	end
  end

  def logout
  	session[:admin_id] = nil
  	redirect_to '/welcome'
  end

  def login
  end

  def welcome
    puts "log #{logged_in?}"
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