class FakerHelper
  
  def self.create_hospital
    hospital = Hospital.new
    name = Faker::Name.name
    address = Faker::Address.street_address + ", Alexandria, Egypt"
    phone = Faker::PhoneNumber.cell_phone
    website = Faker::Internet.domain_name
    email = Faker::Internet.email
    hospital = Hospital.create(name: name, address: address, phone: phone, website: website, email: email)
    hospital
  end
  
  
  def self.create_clinic(specialization)
#    clinic_name = "عيادة الدكتور" + " " + doctor_names[index]
    clinic = Clinic.create(hospital_id: 0, address: "Alexandria, Egypt", specialization_id: "#{specialization.id}")
    doctor = create_doctor(clinic.id)
    clinic.name = doctor.name
    clinic.save
    clinic
  end
  
  
  def self.create_doctor(clinic_id)
  
  name = Faker::Name.name
  email = Faker::Internet.email
  phone = Faker::PhoneNumber.cell_phone
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
  doctor_price = DoctorPrice.create(doctor_id: "#{doctor.id}", clinic_id: "#{clinic.id}", price: "100.00")
  doctor    
  end
  
  
  def self.create_patient(email)
    
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
end