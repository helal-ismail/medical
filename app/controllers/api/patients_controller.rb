class Api::PatientsController < ApiController
  
  api :GET, '/patient', "Get Patient by ID"
  def get_patient
    
  end
  
  api :GET, '/patients', "Get a List of Patients by a Specific Query"
  def get_patients
    
  end

end
