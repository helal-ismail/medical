class Api::AppointmentsController < ApiController

  def new
    appointment = Appointment.create_from_params(params[:appointment])
    render :json=> {:data => appointment}
  end
  
  def edit
   appointment = Appointment.find(params[:id])
   # EDIT DETAILS
   render :json => {:data => appointment, :msg => "Appointment updated"}
  end
  
  
  def cancel
    appointment = Appointment.find(params[:id])
    if appointment.present?
      appointment.status = 'canceled'
      appointment.save
      render :json => {:msg => "Appointment has been canceled"}
    else
      render :json => {:msg => "Appointment not found"}, :status => 400     
    end
  end

  def show
    appointment = Appointment.find(params[:id])
    if appointment.present?
      render :json => {:data => appointment}
    else
      render :jspn => {:msg => "Appointment ID doesn't exist"}, :status => 400
    end
  end


  def add_note
    appointment = Appointment.find(params[:appointment_id])
    response = {}
    status = 200
    if appointment.present?
      appointment.notes = params[:notes]
      appointment.save
      response = {:data => appointment, :success=> true}
    else
      response = {:msg=> "Invalid Appointment ID", :success=> false}
    status = 400
    end
    render :json => response , :status => status
  end

  def get_appointments
    # FETCH APPOINTMENT BY PATIENT AND DOCTOR
    # GET PATIENT ID
    # GET DOCTOR ID
    # CLINIC ID
    # GET DOCTORPRICE OBJECT
    # FIND APPOINTMENTS THAT MAP TO PATIENT AND DOCOTORPRICE
  end
end
