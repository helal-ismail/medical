class Api::PatientsController < ApiController
  
  api :GET, '/patient', "Get Patient by ID"
  param :patient_id, String, :desc => "Patient ID", :required => true
  def get_patient
    
  end
  
  api :GET, '/patients', "Get a List of Patients by a Specific Query"
  def get_patients
    
  end

end
