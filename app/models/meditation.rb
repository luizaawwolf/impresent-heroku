require 'csv'

class Meditation < ApplicationRecord
	
	def self.to_csv(options = {})
		desired_columns = ["Participant", "Date/Time", "Emotions", "Meditation", "Stress Rating Before", "Stress Rating After"]
		CSV.generate(options) do |csv|
			csv << desired_columns 

			all.each  do |meditation|
				user_name = meditation.user 
				date_time = meditation.datetime
				emotions = meditation.emotions 
				med = meditation.meditation
				stressBefore = meditation.stresslevelbefore 
				stressAfter = meditation.stresslevelafter 

				csv << [user_name, date_time, emotions, med, stressBefore, stressAfter ]
			end


		end 
    end
end
