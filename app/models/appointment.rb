class Appointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor_prices
  has_one :doctor, :through => :doctor_prices
  has_one :clinic, :through => :doctor_prices

  def self.create_from_params(params)
    appointment = Appointment.new
    appointment[:patient_id] = params[:patient_id]
    doctor_price = DoctorPrice.where(:doctor_id=>params[:doctor_id], :clinic_id=>params[:clinic_id]).first
    
    appointment[:doctor_price] = doctor_price
    appointment[:discount] = params[:discount]
    original_price = doctor_price.price
    appointment[:price] = original_price - ( param[:discount] * original_price / 100 )
    
    #appointment[:appointment_date] = 
    #appointment[:appointment_time] = 
    #appointment[:state] = ''
    appointment[:counter] = doctor_price.get_next_appointment_num
    appointment.save
    
    appointment
  end
  


end
