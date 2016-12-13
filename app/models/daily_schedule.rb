class DailySchedule < ActiveRecord::Base
  belongs_to :doctor_price
  
  def edit(params)
    start_time = params[:start_time]
    end_time = params[:end_time]
    save
  end
  
  def cancel
    self.destroy
  end
  
end
