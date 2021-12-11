class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :users
  has_many :appointments
  validates :customer_capacity,presence:true

  def get_appointment_list
    return self.appointments.where(date:Date.today).order("time_start").map{|appointment| appointment.time_start}
  end
end
