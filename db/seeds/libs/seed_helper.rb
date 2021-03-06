class SeedHelper


  def self.create_hospital(name, address, phone, website, profile_pic)
    hospital = Hospital.create(name: name, address: address, phone: phone, website: website, image_url: profile_pic)
    hospital
  end

  def self.create_clinic(hospital, specialization)
    clinic = Clinic.create(name: "#{specialization.name}", hospital_id: hospital.id, address: hospital.address, specialization_id: "#{specialization.id}")
    clinic
  end


  def self.create_doctor(clinic_id, name, email, phone, profile_pic)
  password = "123456"
  doctor = Doctor.create(name: name, email: email, username: email, gender: 'male', phone: phone)
  doctor.salt = SecureRandom.hex(4)
  doctor.encrypted_password = Digest::SHA256.hexdigest(password + doctor.salt)
  access_token = Digest::SHA256.hexdigest(DateTime.now.to_s + doctor.salt)
  doctor.access_token = access_token[0..30]
  doctor.channel = "c"+ access_token[0..10]
  uid = Digest::SHA256.hexdigest(DateTime.now.to_s + doctor.salt)
  doctor.uid = uid[0..10]

  spec = Clinic.find(clinic_id).specialization
  desc = "إستشاري" + " " + spec.name
  doctor.description = desc
  doctor.save
  doctor_price = DoctorPrice.create(doctor_id: "#{doctor.id}", clinic_id: "#{clinic_id}", price: "100.00")
  doctor
  end


  def self.create_patient(email)
    password = "123456"
    name = Faker::Name.name
    #email = Faker::Internet.email

    phone = Faker::PhoneNumber.cell_phone
    patient = Patient.create(name: name, email: email, gender: 'male', phone: phone)
    patient.salt = SecureRandom.hex(4)
    patient.encrypted_password = Digest::SHA256.hexdigest(password + patient.salt)
    access_token = Digest::SHA256.hexdigest(DateTime.now.to_s + patient.salt)
    patient.access_token = access_token[0..30]
    patient.channel = "c"+ access_token[0..10]
    uid = Digest::SHA256.hexdigest(DateTime.now.to_s + patient.salt)
    patient.uid = uid[0..10]
    patient.save
    patient
  end

  def self.create_admin(email, role)
    password = "123456"
    name = Faker::Name.name
    #email = Faker::Internet.email

    phone = Faker::PhoneNumber.cell_phone
    admin = SuperAdmin.create(name: name, email: email, gender: 'male', phone: phone, hospital_id:1)
    admin.salt = SecureRandom.hex(4)
    admin.encrypted_password = Digest::SHA256.hexdigest(password + admin.salt)
    access_token = Digest::SHA256.hexdigest(DateTime.now.to_s + admin.salt)
    admin.access_token = access_token[0..30]
    admin.channel = "c"+ access_token[0..10]
    uid = Digest::SHA256.hexdigest(DateTime.now.to_s + admin.salt)
    admin.uid = uid[0..10]
    admin.save
    admin
  end

end
