class Api::ClinicsController < ApiController
  
  api :GET, '/clinics/explore', "Explore Clinics"
  def explore
    if params[:specialization_id].present?
      render :json => {:data=>private_clinics.where(:specialization_id => params[:specialization_id])}
    else
      render :json => {:data=>private_clinics}      
    end

  end
  
  api :POST, '/clinics/search', "Search Clinics"
  def search
    pattern = params[:pattern]
    render :json => {:data=>private_clinics.search_by_pattern(pattern)}
  end
  
  api :GET, '/clinics/profile', "Fetch Clinic Profile"
  def profile

    clinic = Clinic.find(params[:id])
    if clinic.present?
      
     insurance_cos = []
     insurance_cos = [ {:name => "AIG Insurance"},{:name => "AXA Insurance"} ] if clinic.hospital.present?
     render :json => {:data => clinic, :doctors => clinic.doctors, :insurance_companies => insurance_cos }
    else
      render :json => {:msg => "Couldn't find a clinic with the specified ID"}, :status => 400
    end
  end
  
  
  def specializations
    render :json => {:data => Specialization.all}
  end
 
  
  private 
  def private_clinics
    Clinic.private_clinics
  end

end
