class MeditationsController < ApplicationController
skip_before_action :verify_authenticity_token
	def new
		@meditation = Meditation.new
	end

	def create
		@meditation = Meditation.new(:user => params['user'], :datetime => params['datetime'], 
			:stresslevelbefore => params['stressbefore'], :stresslevelafter => params['stressafter'],
			:emotions => params['emotions'], :meditation => params['meditation'])
		# @meditation.save
		if @meditation.save
			puts "SAVED"
		else
			#render 'new'
		end
		render :json => {:message => "Success"}.to_json
	end

	def index
		@meditations = Meditation.all 

		respond_to do |format|
	      format.html
	      format.json { render :json => @meditations } #maybe render json: @meditations
	    end
	end

	def edit
	end

	def show
	end

	def destroy
		@meditation = Meditation.find(params[:id])
		@meditation.destroy
	end
end
