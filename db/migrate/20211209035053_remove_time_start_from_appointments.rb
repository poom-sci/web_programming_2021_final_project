class RemoveTimeStartFromAppointments < ActiveRecord::Migration[6.1]
  def change
    remove_column :appointments, :time_start, :datatime
  end
end
