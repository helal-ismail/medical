class DoctorPrice < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :clinic
  has_many :daily_schedules
  has_many :appointments


def get_next_appointment_num
  appt = self.appointments.last
  if appt.present?
    return appt.counter+1
  else
    return 1
  end
end


end



