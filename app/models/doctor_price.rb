class DoctorPrice < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :clinic
  has_many :daily_schedules
  has_many :appointments

def self.find_by_doctor_and_clinic(doctor_id, clinic_id)
  doctor_price = DoctorPrice.where(:doctor_id=>doctor_id, :clinic_id=>clinic_id).first
  doctor_price
end

def add_daily_schedule(schedule_json)
  schedule = DailySchedule.new
  schedule.day_of_week = schedule_json[:day_of_week]
  schedule.start_time = schedule_json[:start_time]
  schedule.end_time = schedule_json[:end_time]
  schedule.doctor_price = self
  schedule.save
end

def get_next_appointment_num
  appt = self.appointments.last
  if appt.present?
    return appt.counter+1
  else
    return 1
  end
end


end



