class Restaurant < ApplicationRecord
	has_many :tables
	has_many :favourites
	has_many :rates
	has_many :comments

	def get_table_capacity
		return self.tables.pluck('customer_capacity').inject(0){|sum,x| sum + Integer(x) }
	end

	def get_rate_average
		@rate_array=self.rates.pluck('rate_score')
		if  @rate_array.size != 0
			return @rate_array.inject(0.0){|sum,x| sum + Integer(x) }/@rate_array.size
		else 
    		return 0.0
    	end
	end

	def get_all_today_appointment_list
    	return self.tables.order("table_number").map{|table| table.appointments.where(date:Date.today).order("time_start").map{|appointment| appointment.time_start}}
  	end

  	def get_table_list
  		return self.tables.pluck('table_number')
  	end

end
