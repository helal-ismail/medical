class Api::ClinicsController < ApiController

  api :GET, '/clinics/explore', "Explore Clinics"
  def explore
    if params[:specialization_id].present?
      render :json => {:data=>Clinic.where(:specialization_id => params[:specialization_id])}
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
    params[:assign_flag]
    query = DoctorPrice.where(:doctor_id => doctor.id, :clinic_id => params[:clinic_id])
    if params[:assign_flag].present?
        doctor_price = DoctorPrice.create(doctor_id: doctor.id, clinic_id: params[:clinic_id], price: 100) if query.count == 0
    else
      query.first.destroy if query.count > 0
    end
    render :json => {:data => clinic.doctors}
  end


  def specializations
    render :json => {:data => Specialization.all}
  end


  def reports
    response = []
    params[:ids].each do |clinic_id|
      clinic = Clinic.find(clinic_id)
      response << clinic.appointments_by_period(params[:date_start], params[:date_end])
    end
    @date_start = params[:date_start]
    @data = response
    #to_csv
    respond_to do |format|
      format.json {render :json => response}
      format.csv { send_data to_csv }
    end
  end


  def to_csv
    CSV.generate do |csv|
      date = Date.parse(@date_start)
      num_days = @data.count
      column_names = ["Date"]
      last_row = ["Total"]
      num_days = 0
      @data.each do |record|
        column_names << record[:clinic_name]
        last_row << 0
        num_days = record[:data].count
      end
      csv << column_names
      num_days.times do |i|
        row = [date]
        @data.each_with_index do |record,j|
          row << record[:data][i][:count]
          last_row[j+1] = last_row[j+1].to_i + record[:data][i][:count].to_i
        end
        csv << row
        date = date + 1
      end
      csv << last_row
    end
  end

  def new
    clinic = nil
    if params[:clinic_id].to_i > 0
      clinic = Clinic.find(params[:clinic_id])
    else
      clinic = Clinic.new
    end
    clinic.hospital_id = params[:hospital_id]
    clinic.address = params[:address]
    clinic.name = params[:name]
    clinic.phone = params[:phone]
    clinic.specialization_id = params[:specialization_id]
    clinic.save

    render :json => { :data => clinic }
  end





  private
  def private_clinics
    Clinic.private_clinics
  end

end
