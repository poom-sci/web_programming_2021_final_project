class User < ApplicationRecord
	has_secure_password
	validates :email,presence:true,uniqueness:true
	validates :display_name, presence: true,uniqueness:true,length: {minimum: 4}
	validates :password_digest,presence:true
	validates_confirmation_of :password

	has_many :likes
	has_many :comments
	has_many :rates
	has_many :favourites
	has_many :appointments

	def get_today_appointments
    return self.appointments.where(date:Date.today).order("time_start")
	end
end
