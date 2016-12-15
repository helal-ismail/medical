# Unified PASSWORD
password = "123456"

# Hospitals
Hospital.create(name: 'German Hospital', address: 'Qesm AR Ramel سابا محطة باشا, Fleming, Qism El-Raml, Alexandria Governorate', uid: '1', phone: '123123123', website: 'www.hospital.com', email: 'contact@hospital.com')
Hospital.create(name: 'Louran Hospital', address: 'St. - Louran, 13 Shaarawy, San Stifano, Qesm AR Ramel, Alexandria Governorate', uid: '2', phone: '123123123', website: 'www.hospital.com', email: 'contact@hospital.com')
Hospital.create(name: 'Andalusia Hospital', address: '35 Bahaa Eldeen ElGhatoury street, Alexandria, Egypt', uid: '3', phone: '123123123', website: 'www.hospital.com', email: 'contact@hospital.com')
Hospital.create(name: 'ICC Hospital', address: '24 Bahaa Eldeen ElGhatoury street, Alexandria, Egypt', uid: '4', phone: '123123123', website: 'www.hospital.com', email: 'contact@hospital.com')

spec_names = ["أمراض القلب","أمراض الباطنية","العيون والابصار","الأوعية الدموية","الأسنان والتركيبات", "الأنف و الأذن", "الأمراض الجلدية", "الأمراض النفسية","الأمراض الصدرية", "العظام والمفاصل", "المسالك البولية والتناسلية","الاشعة والتصوير","الجهاز الهضمي", "النساء والولادة", "الجراحة", "الاورام"]
specs = []
spec_names.each do |spec|
   specs << Specialization.create(name: "#{spec}")
end


Hospital.all.each do |hospital|
  Clinic.create(name: "#{specs[0].name}", uid: hospital.id.to_s+'1', hospital_id: hospital.id, address: hospital.address, specialization_id: "#{specs[0].id}")
  Clinic.create(name: "#{specs[1].name}", uid: hospital.id.to_s+'2', hospital_id: hospital.id, address: hospital.address, specialization_id: "#{specs[1].id}")
  Clinic.create(name: "#{specs[2].name}", uid: hospital.id.to_s+'3', hospital_id: hospital.id, address: hospital.address, specialization_id: "#{specs[2].id}")
  Clinic.create(name: "#{specs[3].name}", uid: hospital.id.to_s+'4', hospital_id: hospital.id, address: hospital.address, specialization_id: "#{specs[3].id}")
end


hospital = Hospital.first
clinic = hospital.clinics.first


# Doctor / binding with clinic / Schedule
doctor = Doctor.create(name: 'أحمد محمد', uid: '123xyz', email: 'doctor@appointik.com', username: 'doctor', gender: 'male', phone: '0101231237')
doctor.salt = SecureRandom.hex(4)
doctor.encrypted_password = Digest::SHA256.hexdigest(password + doctor.salt)
access_token = Digest::SHA256.hexdigest(DateTime.now.to_s + doctor.salt)
doctor.access_token = access_token[0..30]
doctor.channel = "c"+ access_token[0..10]
uid = Digest::SHA256.hexdigest(DateTime.now.to_s + doctor.salt)
doctor.uid = uid[0..10]
doctor.description = "إستشاري أمراض القلب"
doctor.save


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
