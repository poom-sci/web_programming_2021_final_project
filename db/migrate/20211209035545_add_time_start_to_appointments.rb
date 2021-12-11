class AddTimeStartToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :time_start, :integer
  end
end
