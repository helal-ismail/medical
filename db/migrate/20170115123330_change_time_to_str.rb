class ChangeTimeToStr < ActiveRecord::Migration
  def change
    change_column :appointments, :appointment_time, :string, :default => ""
    change_column :daily_schedules, :start_time, :string, :default => ""
    change_column :daily_schedules, :end_time, :string, :default => ""
  end

end
