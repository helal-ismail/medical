class Appointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor_price
  has_one :doctor, :through => :doctor_prices
  has_one :clinic, :through => :doctor_prices
  enum state: [ :pending, :confirmed, :past, :canceled ]

  def self.create_from_params(params)
    appointment = Appointment.new
    appointment.patient_id = params[:patient_id]
    appointment.appointment_date = Date.parse(params[:appointment_date])
    appointment.appointment_time = Time.parse(params[:appointment_time])

    doctor_price = DoctorPrice.find_by_doctor_and_clinic(params[:doctor_id], params[:clinic_id])
    appointment.doctor_price = doctor_price
    appointment.discount = params[:discount]
    original_price = 100
    appointment.price = original_price - ( params[:discount].to_i * original_price / 100 )
    appointment.state = 'pending'

    appointment.save

    appointment
  end

  # Params : id, date & time
  def self.edit_appointment_with_params(params)
    appointment = Appointment.find(params[:id])
    appointment[:appointment_date] = Date.parse(params[:appointment_date])
    appointment[:appointment_time] = Time.parse(params[:appointment_time])
    appointment[:state] = 'pending'

    appointment.save
    appointment
  end

  # Params : patient_id, doctor_id & clinic_id
  def self.get_all_appointments_with_params(params)
    doctor_price = DoctorPrice.find_by_doctor_and_clinic(params[:doctor_id], params[:clinic_id])
    appointments = Appointment.where(:patient_id => params[:patient_id], :doctor_price_id => doctor_price)

    appointments
  end


  def as_json(options)
        # super(:only => [:id, :discount, :price, :patient_id, :appointment_date, :appointment_time])
        result = {:id => self.id, :discount => self.discount, :price => self.price, :state => self.state,
                  :appointment_date => self.appointment_date, :appointment_time => self.appointment_time,
                  :patient_id => self.patient.id, :patient_name => self.patient.name,
                  :doctor_id => self.doctor_price.doctor.id, :doctor_name => self.doctor_price.doctor.name,
                  :notes => self.notes}
  end


end
