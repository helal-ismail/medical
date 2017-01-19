class DailySchedule < ActiveRecord::Base
  belongs_to :doctor_price

  def edit(params)
    self.start_time = params[:start_time]
    self.end_time = params[:end_time]
    self.save
  end

  def cancel
    self.destroy
  end

 def as_json(options)
    result = {
              #:day_of_week => "#{Date::DAYNAMES[self.day_of_week]}",
              :start_time => "#{self.start_time}",
              :end_time => "#{self.end_time}"
              }
    result
  end

end
