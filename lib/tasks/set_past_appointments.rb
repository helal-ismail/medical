module Scheduler
  
  def self.set_past_appointments
    Appointments.where("appointment_date < ? AND state = 'confirmed' ", Date.today).each do |appointment|
      appointment.state = 'past'
      appointment.save
    end
  end
end