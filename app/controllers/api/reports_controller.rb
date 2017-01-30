class Api::ReportsController < ApiController

  def doctors
    doctor_ids = params[:doctor_ids]
    period_start = params[:start]
    period_end = params[:end]

    doctor_ids.each do |doctor_id|
      doctor = Doctor.find(doctor_id)
      appointments = doctor.appointments_by_period(period_start, period_end)
    end

  end



end
