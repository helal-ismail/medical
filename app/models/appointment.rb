class Appointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor_price
  has_one :doctor, :through => :doctor_prices
  has_one :clinic, :through => :doctor_prices
  enum state: [ :confirmed, :checkedin, :past, :canceled, :missed ]
  has_one :feedback

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
    appointment.state = 'confirmed'

    appointment.save


    Notification.push("appointment", appointment.id, appointment.patient,"New Appointment", "A new Appointment has been created", "تم حجز موعد جديد" )
    Notification.push("appointment", appointment.id, doctor_price.doctor,"New Appointment", "A new Appointment has been created", "تم حجز موعد جديد" )


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

        date = Date.today
        if date > self.appointment_date && self.state!= 'canceled'
          self.state = 'past'
          self.save
        end

        stars = 0
        stars = self.feedback.stars if self.feedback.present?

        hospital_name = ""
        hospital_id = 0

        if self.doctor_price.clinic.hospital.present?
          hospital_name = self.doctor_price.clinic.hospital.name
          hospital_id = self.doctor_price.clinic.hospital.id
        end
        # super(:only => [:id, :discount, :price, :patient_id, :appointment_date, :appointment_time])
        result = {:id => self.id, :discount => self.discount, :price => self.price, :state => self.state,
                  :appointment_date => self.appointment_date, :appointment_time => self.appointment_time,
                  :patient_id => self.patient.id, :patient_name => self.patient.name,
                  :doctor_id => self.doctor_price.doctor.id, :doctor_name => self.doctor_price.doctor.name, :doctor_description => self.doctor_price.doctor.description,
                  :notes => self.notes || '', :clinic_id => self.doctor_price.clinic.id, :clinic_name => self.doctor_price.clinic.name, :specialization => self.doctor_price.clinic.specialization.name, :feedback => stars, :hospital_name => hospital_name, :hospital_id => hospital_id }
  end


end
