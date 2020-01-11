class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	def new
		@user = User.new
	end

	def create
		@user = User.new(:email => params['email'], :password => params['password'])
		# @meditation.save
		if @user.save
			puts "SAVED"
		else
			#render 'new'
		end
		render :json => {:message => "Success"}.to_json
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
		@user = User.find_by_email(params['email'])
		@attempted_password = params['password']
		if @user
			if @attempted_password == @user.password
				render :json => {:message => "Success"}.to_json
			else
				render :json => {:message => "Denied"}.to_json
			end
		else
			render :json => {:message => "User does not exist"}.to_json
		end
	end
end
