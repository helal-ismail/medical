class Api::ClinicsController < ApiController
  
  api :GET, '/clinics/explore', "Explore Clinics"
  def explore
    render :json => {:data=>private_clinics}
  end
  
  api :POST, '/clinics/search', "Search Clinics"
  def search
    pattern = params[:pattern]
    render :json => {:data=>private_clinics.search_by_pattern(pattern)}
  end
  
  api :GET, '/clinics/profile', "Fetch Clinic Profile"
  def profile
    uid = params[:uid]
    id = params[:id]
    clinic = Clinic.find_by_uid(uid)
    if clinic.present?
      render :json => {:data => clinic, :doctors => clinic.doctors}
    else
      render :json => {:msg => "Couldn't find a clinic with the specified ID"}, :status => 400
    end
  end
  
  
 
  
  private 
  def private_clinics
    Clinic.private_clinics
  end

end
