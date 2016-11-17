class Api::HospitalsController < ApiController
  
  api :GET, '/hospitals/explore', "Explore Hospitals"
  def explore
    render :json => {:data=>Hospital.all}
  end
  
  api :POST, '/hospitals/search', "Explore Hospitals"
  def search
    pattern = params[:pattern]
    render :json => {:data=>Hospital.search_by_pattern(pattern)}
  end
  
  api :GET, '/hospitals/profile', "Fetch Hospital Profile"
  def profile
    uid = params[:uid]
    id = params[:id]
    hospital = Hospital.find_by_uid(uid)
    if hospital.present?
      render :json => {:data => hospital}
    else
      render :json => {:msg => "Couldn't find a hospital with the specified ID"}, :status => 400
    end
  end
  
  

end
