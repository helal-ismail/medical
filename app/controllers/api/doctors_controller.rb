class Api::DoctorsController < ApiController
  include ActionView::Helpers::NumberHelper

  def add_schedule
    doctor = Doctor.find_by_uid(params[:doctor_uid])
    clinic = Clinic.findi_by_uid(params[:clinic_uid])
    doctor_price  = DoctorPrince.find_by_doctor_and_clinic
    doctor_price.add_daily_schedule(params) if doctor_price.present?

    render :json => {:msg =>"Schedule updated"}

  end

  def get_appointments
    date = Date.parse(params[:date])
    day_of_week = date.wday
    doctor = Doctor.find_by_uid(params[:doctor_uid])
    clinic = Clinic.findi_by_uid(params[:clinic_uid])
    if doctor.present? && clinic.present?
      doctor_price  = DoctorPrince.find_by_doctor_and_clinic
      if doctor_price.present?
        schedules = doctor_price.daily_schedules.where(:day_of_week => day_of_week )
        render :json => {:data => schedules}
      end
    end
    render :json => {:msg => "Something went wrong"}, :status => 500

  end

  def profile
    doctor = Doctor.find(params[:id])
    if doctor.present?
      render :json => {:data => doctor.as_json(:detailed_info=> true)}
    else
      render :json => {:msg => "Doctor ID not found"}, :status => 400
    end
  end

  def clinics
    doctor = Doctor.find(params[:id])
    if doctor.present?
      render :json => {:data => doctor.clinics }
    else
      render :json => {:msg => "Doctor ID not found"}, :status => 400
    end
  end

  def reports
    response = []
    params[:ids].each do |doctor_id|
      doctor = Doctor.find(doctor_id)
      response << doctor.appointments_by_period(params[:date_start], params[:date_end])
    end
    @date_start = params[:date_start]
    @data = response
    #to_csv
    respond_to do |format|
      format.json {render :json => response}
      format.csv { send_data to_csv, filename: "reports.csv" }
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
        column_names << record[:doctor_name]
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


  api :GET, '/doctor/schedule', "Get Doctor's Schedule"
  param :doctor_id, String, :desc => "Doctor ID", :required => true
  param :clinic_id, String, :desc => "Clinic ID", :required => true

  def get_schedule
    doctor_price = DoctorPrice.find_by_doctor_and_clinic(params[:doctor_id], params[:clinic_id])
    render :json => {:success => true, :data => doctor_price.daily_schedule}
  end

  api :POST, '/doctor/search', "Search Doctors"
  def search
    pattern = params[:pattern]
    render :json => {:data=>Doctor.search_by_pattern(pattern)}
  end


  api :POST, '/doctor/add_feedback', "Add Feedback"
  def add_feedback

    if(!(1..5).include? params[:stars])
      render :json => {:msg => "Rating out of rang!"}, :status => 500 and return
    end

    params[:entity_type] = "Doctor"
    params[:entity_id] = params[:doctor_id]
    feedback = Feedback.add_feedback_with_params(params)

    if feedback.present?
      render :json => {:data => feedback}
    else
      render :json => {:msg => "Something went wrong!"}, :status => 400
    end
  end

  api :GET, '/doctor/get_feedback', "Get Feedback"
  def get_feedback
    feedbacks = Feedback.get_feedback("Doctor", params[:doctor_id])

    if feedbacks.present?
      rating = 0
      feedbacks.each do |f|
        rating += f.stars
      end

      rating = rating.to_f / feedbacks.length
      rating = number_with_precision(rating, :precision => 2)
      render :json => {:data => feedbacks, :total_rate => rating}
    else
      render :json => {:msg => "Feedback not found!"}, :status => 400
    end
  end

end
