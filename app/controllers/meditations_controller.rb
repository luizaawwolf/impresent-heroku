require 'net/http'
require 'json'
require 'uri'

class MeditationsController < ApplicationController
skip_before_action :verify_authenticity_token
skip_before_action :authorized, only: [:new, :create]
	def new
		@admin = Admin.find_by(username: params[:username])
	  	if @admin && @admin.authenticate(params[:password])
			@meditation = Meditation.new
		else
			render json: 404
		end
	end

	def create
		puts "AT CREATE"
		@admin = Admin.find_by(username: params[:username])
	  	if @admin && @admin.authenticate(params[:password])
	      	session[:admin_id] = @admin.id
	      	#make meditation
	    	@meditation = Meditation.new(:user => params['user'], :datetime => params['datetime'], 
			:stresslevelbefore => params['stressbefore'], :stresslevelafter => params['stressafter'],
			:emotions => params['emotions'], :meditation => params['meditation'])
			if @meditation.save
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
		@meditations = Meditation.all 

		
		respond_to do |format|
	      format.html
	      format.js
	      format.csv {send_data @meditations.to_csv, filename: "meditationData.csv"}
	      format.json do 
	      	render json: @meditations.to_json
	      end

	    end
	end

	def edit
		@meditation = Meditation.find(params[:id])
	end

	def show
		@meditation = Meditation.find(params[:id])
	end

	def destroy
		@meditation = Meditation.find(params[:id])
		@meditation.destroy
	end

	def to_csv(options = {})
		desired_columns = ["Participant", "Date/Time", "Emotions", "Meditation", "Stress Rating Before", "Stress Rating After"]
		CSV.generate(options) do |csv|
			csv << desired_columns 
			@meditations.each  do |meditation|
				user_name = meditation.user 
				date_time = meditation.datetime
				emotions = meditation.emotions 
				med = meditation.meditation
				stressBefore = meditation.stresslevelbefore 
				stressAfter = medtiation.stresslevelafter 

				csv << [user_name, date_time, emotions, med, stressBefore, stressAfter ]
			end


		end 
    end

    def numberOfMeds 
    	user_name = params['user'] 
    	count = 0 
    	Meditation.all.each do |meditation| 
    		if meditation.user == user_name 
    			count = count + 1
    		end 
    	end

    	render :json => count  
    end 
end
