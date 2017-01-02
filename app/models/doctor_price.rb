class DoctorPrice < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :clinic
  has_many :daily_schedules
  has_many :appointments
  
  def self.find_by_doctor_and_clinic(doctor_id, clinic_id)
    doctor_price = DoctorPrice.where(:doctor_id=>doctor_id, :clinic_id=>clinic_id).first
    doctor_price
  end
  
  def appointments_by_date(date)
    self.appointments.where("appointment_date = ? ", date)
  end

  def add_daily_schedule(days_params)
    days_params.each do |schedule_params|
      schedule = DailySchedule.new
      schedule.day_of_week = schedule_params[:day_of_week]
      schedule.start_time = schedule_params[:start_time]
      schedule.end_time = schedule_params[:end_time]
      schedule.doctor_price = self
      schedule.save
    end
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

