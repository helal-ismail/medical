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

      insurance_cos = [ {:name => "AIG Insurance", :website=>"http://aig.com"},{:name => "AXA Insurance", :website => "http://axa.com"} ]
      render :json => {:data => hospital, :clinics => hospital.clinics, :insurance_companies => insurance_cos}
    else
      render :json => {:msg => "Couldn't find a hospital with the specified ID"}, :status => 400
    end
  end

  def new
    if params[:hospital_id].to_i > 0
      hospital = Hospital.find(params[:hospital_id])
      hospital.update(name: params[:name], address: params[:address], phone: params[:phone], website: params[:website], email: params[:email])
    else
      hospital = Hospital.create(name: params[:name], address: params[:address], phone: params[:phone], website: params[:website], email: params[:email])
    end
    render :json => {:data => hospital }
  end



end
