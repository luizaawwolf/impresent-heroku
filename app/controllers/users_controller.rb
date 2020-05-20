class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	skip_before_action :authorized, only: [:new, :create, :validate]
	def new
		@admin = Admin.find_by(username: params[:username])
	  	if @admin && @admin.authenticate(params[:password])
			@user = User.new
		else
			render json: 404
		end
	end

	def create
		@admin = Admin.find_by(username: params[:username])
		puts "CREATE"
	  	if @admin && @admin.authenticate(params[:password])
	  		puts "ADMIN VALID"
			@user = User.new(:email => params['email'], :password => params['userpassword'])
			if @user.save
				puts "SAVED"
			else
				#render 'new'
			end
			render :json => {:message => "Success"}.to_json
		else
	      respond_to do |format|
	        format.json { render json: 404 }
	      end
	  	end
	end

	def index
		@users = User.all 

		respond_to do |format|
	      format.html
	      format.json { render :json => @users } #maybe render json: @meditations
	    end
	end

	def edit
	end

	def show
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
	end

	def validate
		@admin = Admin.find_by(username: params[:username])
		puts "Testing admin..."
		puts @admin 
		if @admin && @admin.authenticate(params[:password])
	  		@user = User.find_by_email(params['email'])
			@attempted_password = params['userpassword']
			puts "Validating...."
			if @user
				puts "Better..."
				if @attempted_password == @user.password
					puts "Best..."
					render :json => {:message => "Success"}.to_json
				else
					puts "Exit..."
					render :json => {:message => "Denied"}.to_json
				end
			else
				render :json => {:message => "User does not exist"}.to_json
			end
		else
	      respond_to do |format|
	        format.json { render json: 404 }
	      end
	  	end
	end
end
