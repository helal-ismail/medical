class Api::SchedulesController < ApiController
  def new
    doctor_price  = DoctorPrice.find_by_doctor_and_clinic(params[:doctor_id], params[:clinic_id])
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

  def show
  #  doctor_price = DoctorPrice.find_by_doctor_and_clinic(params[:doctor_id], params[:clinic_id])
#    if doctor_price.daily_schedules.count == 0
      result = [{:start_time => "١٠:٠٠ ص", :end_time => "٠١:٠٠ م"},{:start_time => "٠٧:٠٠ م", :end_time => "١٠:٠٠ م"}]
#      daily_schedule.day_of_week = 1
#      doctor_price.daily_schedules << daily_schedule
#    end
    render :json => {:data => result}
  end



end
