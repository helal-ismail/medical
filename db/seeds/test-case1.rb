# Unified PASSWORD
password = "123456"

# Hospital
hospital = Hospital.first

# Clinic and Spec
specialization = Specialization.create(name: 'أمراض القلب')
clinic = hospital.clinics.first
clinic.specialization = specialization
clinic.save

# Doctor / binding with clinic / Schedule
doctor = Doctor.create(name: 'أحمد محمد', uid: '123xyz', email: 'doctor@appointik.com', username: 'doctor', gender: 'male', phone: '0101231237')
doctor.salt = SecureRandom.hex(4)
doctor.encrypted_password = Digest::SHA256.hexdigest(password + doctor.salt)
access_token = Digest::SHA256.hexdigest(DateTime.now.to_s + doctor.salt)
doctor.access_token = access_token[0..30]
doctor.channel = "c"+ access_token[0..10]
uid = Digest::SHA256.hexdigest(DateTime.now.to_s + doctor.salt)
doctor.uid = uid[0..10]
doctor.save

#Qualification.create()

doctor_price = DoctorPrice.create(doctor_id: "#{doctor.id}", clinic_id: "#{clinic.id}", price: "100.00")
index = 0
7.times do
  DailySchedule.create(doctor_price_id: "#{doctor_price.id}", start_time: "10:00", end_time: "12:00", day_of_week: "#{index}")
  index = index + 1
end

# Patient
patient = Patient.create(name: 'John Smith', uid: '1234xyzz', email: 'patient@appointik.com', username: 'patient', gender: 'male', phone: '0101231237')
patient.salt = SecureRandom.hex(4)
patient.encrypted_password = Digest::SHA256.hexdigest(password + patient.salt)
access_token = Digest::SHA256.hexdigest(DateTime.now.to_s + patient.salt)
patient.access_token = access_token[0..30]
patient.channel = "c"+ access_token[0..10]
uid = Digest::SHA256.hexdigest(DateTime.now.to_s + patient.salt)
patient.uid = uid[0..10]
patient.save


# Appointments
Appointment.create(uid: "123x", discount: "0", price: "100", appointment_date: "10/10/2016", appointment_time: "10:00", counter: "1", state: "past", doctor_price_id: "#{doctor_price.id}", patient_id: "#{patient.id}")
Appointment.create(uid: "123y", discount: "0", price: "100", appointment_date: "15/12/2016", appointment_time: "10:00", counter: "1", state: "confirmed", doctor_price_id: "#{doctor_price.id}", patient_id: "#{patient.id}")
