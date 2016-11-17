class Api::HospitalsController < ApiController
  
  api :GET, '/hospitals/explore', "Explore Hospitals"
  def explore
    render :json => {:success=>true, :data=>Hospital.all}
  end
  
  api :GET, '/hospitals/search', "Explore Hospitals"
  def search
    pattern = params[:pattern]
    render :json => {:success=>true, :data=>Hospital.search_by_pattern(pattern)}
  end
  
  

end
