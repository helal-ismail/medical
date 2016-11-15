class Api::HospitalsController < ApiController
  
  api :GET, '/hospitals/explore', "Explore Hospitals"
  def explore
    render :json => {:success=>true, :data=>Hospital.all}
  end
  

end
