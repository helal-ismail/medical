class Api::PatientsController < ApiController
  

  def profile
    patient = Patient.find_by_uid(params[:uid])
    if patient.present?
      render :json => {:data => patient}
    else
      render :json => {:msg => "Patiend UID not found"}, :status => 400
    end
  end
  
  def appointments
    uid = params[:uid]
    patient = Patient.find_by_uid(uid)
    if patient.present?
      render :json => {:data => patient.appointments}
    else
      render :json => {:msg => "Patient UID not found"}, :status => 400
    end
  end
  
  

end
