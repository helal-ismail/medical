class Api::SchedulesController < ApiController
  def create
    doctor_price  = DoctorPrince.find_by_doctor_and_clinic(params[:doctor_id], params[:clinic_id])
    doctor_price.add_daily_schedule(params[:schedule]) if doctor_price.present?
    render :json => {:msg =>"Schedule updated"}
  end

  def edit
    daily_schedule = DailySchedule.find(params[:id])
    if daily_schedule.present?
      daily_schedule.edit(params)
      render :json => {:data => daily_schedule}
    else
      render :json => {:msg => "Error has occured"}, :status => 400
    end
  end

  def cancel
    daily_schedule = DailySchedule.find(params[:id])
    if daily_schedule.present?
      daily_schedule.cancel
      render :json => {:msg => "Schedule has been removed"}
    else
      render :json => {:msg => "Error has occured"}, :status => 400
    end
  end

  def get_schedule
    doctor_price = DoctorPrice.find_by_doctor_and_clinic(params[:doctor_id], params[:clinic_id])
    render :json => {:data => doctor_price.daily_schedule}
  end

  def schedule
    uid = params[:uid]
    doctor = Doctor.find_by_uid(uid)
    if doctor.present?
      start_time = "2:00pm"
      count = 0
      duration = 15*60
      slots = []
      9.times do
        time = (Time.parse(start_time) + count * duration).strftime("%r")
        count+=1
        available = true
        available = false if count % 2 == 0
        slot = {:time => time, :availabe => available}
        slots << slot
      end
      render :json => {:data => slots}
    else
      render :json => {:msg => "Doctor UID not found"}, :status => 400
    end
  end

end
