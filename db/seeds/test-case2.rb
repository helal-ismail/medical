password = "123456"
spec_names = ["أمراض القلب","أمراض الباطنية","العيون والابصار","الأوعية الدموية"]
specs = []
spec_names.each do |spec|
   specs << Specialization.create(name: "#{spec}")
end

doctor_names = ["أحمد محمد", "محمود عبد الله", "سيد موسى","عمرو عبد الناصر","شريف حازم"]
doctor_emails = ["d1@example.com", "d2@example.com","d3@example.com","d4@example.com", "d5@example.com"]

5.times do |index|
  random_index = Random.new.rand(specs.count)
  
  clinic_name = "عيادة الدكتور" + " " + doctor_names[index]
  clinic = Clinic.create(name: "#{clinic_name}", hospital_id: 0, address: "Alexandria, Egypt", specialization_id: "#{specs[random_index].id}")
  
  doctor = Doctor.create(name: "#{doctor_names[index]}", email: "#{doctor_emails[index]}", username: "#{doctor_emails[index]}", gender: 'male', phone: '0101231237')
  doctor.salt = SecureRandom.hex(4)
  doctor.encrypted_password = Digest::SHA256.hexdigest(password + doctor.salt)
  access_token = Digest::SHA256.hexdigest(DateTime.now.to_s + doctor.salt)
  doctor.access_token = access_token[0..30]
  doctor.channel = "c"+ access_token[0..10]
  uid = Digest::SHA256.hexdigest(DateTime.now.to_s + doctor.salt)
  doctor.uid = uid[0..10]
  
  desc = "إستشاري" + " " + spec_names[random_index]
  doctor.description = desc
  doctor.save
  doctor_price = DoctorPrice.create(doctor_id: "#{doctor.id}", clinic_id: "#{clinic.id}", price: "100.00")
end