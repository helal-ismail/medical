class Api::PatientsController < ApiController


  def profile
    patient = Patient.find_by_uid(params[:id])
    if patient.present?
      render :json => {:data => patient}
    else
      render :json => {:msg => "Patiend ID not found"}, :status => 400
    end
  end


  api :POST, '/patient/search', "Search Patient"
  def search
    pattern = params[:pattern]
    render :json => {:data => Patient.search_by_pattern(pattern)}
  end


end
