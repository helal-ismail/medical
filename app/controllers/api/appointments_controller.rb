class Api::AppointmentsController < ApiController
  def new
    appointment = Appointment.create_from_params(params[:appointment])
    if appointment.present?
      render :json=> {:data => appointment}
    else
      render :json => {:msg => "Appointment creation failed"}, :status => 400
    end
  end

  def edit
    appointment = Appointment.edit_appointment_with_params(params)
    if appointment.present?
      render :json => {:data => appointment}
    else
      render :json => {:msg => "Appointment not found"}, :status => 400
    end
  end

  def cancel
    appointment = Appointment.find(params[:id])
    if appointment.present?
      appointment.state = 'canceled'
      appointment.notes = params[:notes] || 'Canceled'
      
      appointment.save
      render :json => {:msg => "Appointment has been canceled"}
    else
      render :json => {:msg => "Appointment not found"}, :status => 400
    end
  end

  def show
    appointment = Appointment.find(params[:id])
    if appointment.present?
      render :json => {:data => appointment }
    else
      render :json => {:msg => "Appointment not found"}, :status => 400
    end
  end

  def add_notes
    appointment = Appointment.find(params[:id])
    response = {}
    status = 200
    if appointment.present?
      appointment.notes = params[:notes]
      appointment.save
      response = {:data => appointment}
    else
      response = {:msg => "Invalid Appointment ID"}
    status = 400
    end
    render :json => response , :status => status
  end

  def by_all_params
    appointments = Appointment.get_all_appointments_with_params(params)
    if appointments.present?
      render :json => {:data => appointments }
    else
      render :json => {:msg => "Appointment not found" }, :status => 400
    end
  end

  def by_patient
    patient = Patient.find(params[:id])
    if patient.present?
      render :json => {:data => patient.appointments}
    else
      render :json => {:msg => "Couldn't find patient with specified ID"}, :status => 400
    end
  end

  def by_doctor_and_clinic
    doctor_price = DoctorPrice.find_by_doctor_and_clinic(params[:doctor_id], params[:clinic_id])
    if doctor_price.present?
      if params[:date].present?
        render :json => {:data => doctor_price.appointments_by_date(params[:date])}
      else
        render :json => {:data => doctor_price.appointments}
      end
    else
      render :json => {:msg => "Couldn't find records for specified IDs"}, :status => 400
    end
  end
  

end
