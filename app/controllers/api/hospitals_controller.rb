class Api::HospitalsController < ApiController
  
  api :GET, '/hospitals/explore', "Explore Hospitals"
  def explore
    render :json => {:data=>Hospital.all}
  end
  
  api :POST, '/hospitals/search', "Search Hospitals"
  def search
    pattern = params[:pattern]
    render :json => {:data=>Hospital.search_by_pattern(pattern)}
  end
  
  api :GET, '/hospitals/profile', "Fetch Hospital Profile"
  def profile
    hospital = Hospital.find(params[:id])
    if hospital.present?
      render :json => {:data => hospital, :clinics => hospital.clinics}
    else
      render :json => {:msg => "Couldn't find a hospital with the specified ID"}, :status => 400
    end
  end
  
  

end
