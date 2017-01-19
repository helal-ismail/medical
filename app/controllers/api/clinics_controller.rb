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
     insurance_cos = [ {:name => "AIG Insurance", :website=>"http://aig.com"},{:name => "AXA Insurance", :website => "http://axa.com"} ] if clinic.hospital.present?
     render :json => {:data => clinic, :doctors => clinic.doctors, :insurance_companies => insurance_cos }
    else
      render :json => {:msg => "Couldn't find a clinic with the specified ID"}, :status => 400
    end
  end

  def assign_doctor
    doctor = Doctor.where(:uid => params[:doctor_uid]).first
    clinic = Clinic.find(params[:clinic_id])
    query = DoctorPrice.where(:doctor_id => doctor.id, :clinic_id => params[:clinic_id])
    if query.count == 0
      doctor_price = DoctorPrice.create(doctor_id: doctor.id, clinic_id: params[:clinic_id], price: 100)
    end
    render :json => {:data => clinic.doctors}
  end


  def specializations
    render :json => {:data => Specialization.all}
  end


  private
  def private_clinics
    Clinic.private_clinics
  end

end
