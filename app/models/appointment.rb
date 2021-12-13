class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :table
  validates :time_start,presence:true
  validates :date,presence:true


  def get_time
    return (self.date.to_s+' '+((self.time_start*2+10).to_s+':00')).to_time
  end
# @appointment.get_time()

  # enum time_start: {
  #   '10:00':0,
  #   '12:00':1,
  #   '14:00':2,
  #   '16:00':3,
  #   '17:00':4,
  #   '18:00':5,
  #   '20:00':6
  # }

end
