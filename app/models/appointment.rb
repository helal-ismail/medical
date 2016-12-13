class Appointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor_prices
  has_one :doctor, :through => :doctor_prices
  has_one :clinic, :through => :doctor_prices
  enum state: [ :pending, :confirmed, :past, :canceled ]

  def self.create_from_params(params)
    appointment = Appointment.new
    appointment[:patient_id] = params[:patient_id]
    appointment[:appointment_date] = Date.parse(params[:appointment_date])
    appointment[:appointment_time] = Time.parse(params[:appointment_time])    
    
    doctor_price = find_by_doctor_and_clinic(params[:doctor_id], params[:clinic_id])        
    appointment[:doctor_price] = doctor_price
    appointment[:discount] = params[:discount]
    original_price = 100
    appointment[:price] = original_price - ( params[:discount].to_i * original_price / 100 )
    appointment[:state] = 'pending'
    
    appointment.save
    
    appointment
  end
  
  def as_json(options)
        super(:only => [:id, :discount, :price, :patient_id, :appointment_date, :appointment_time])
  end


end
