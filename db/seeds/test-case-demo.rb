require_relative "libs/seed_helper"

# Unified PASSWORD
password = "123456"


spec_names = ["أمراض القلب","أمراض الباطنية","العيون والابصار","الأوعية الدموية","الأسنان والتركيبات", "الأنف و الأذن", "الأمراض الجلدية", "الأمراض النفسية","الأمراض الصدرية", "العظام والمفاصل", "المسالك البولية والتناسلية","الاشعة والتصوير","الجهاز الهضمي", "النساء والولادة", "الجراحة", "الاورام"]
image_urls = ["ic_heart_clinic.png", "ic_internal_medicine_clinic.png", "ic_eye_clinic.png","ic_surgery_clinic.png","ic_dental_clinic.png", "ic_nose_clinic.png", "ic_dermatology_clinic.png", "ic_mental_clinic.png", "ic_thoracic_clinic.png","ic_bones_clinic.png","ic_urinary_clinic.png", "ic_x_ray_clinic.png", "ic_digestive_clinic.png", "ic_obstetrics_gynecology_clinic.png", "ic_surgery_clinic.png", "ic_tumors_clinic.png"]

i = 0
spec_names.each do |spec|
   Specialization.create(name: "#{spec}", image_url: "#{image_urls[i]}")
   i = i + 1
end
specializations = Specialization.all

# CREAT MEDICAL CENTERS
hospital = SeedHelper::create_hospital("Adama Medical Center", "Prince Mohammed Bin Abdulaziz St, Al Rawdah, Bin Homran trade center, Gate B, 1st floor, Jeddah 23432, Saudi Arabia", "+966 12 660 0000", "https://www.adamahealthcare.com", "https://www.makan-me.com/uploads/c1544c20-7821-11e5-a53d-c34f70001d1fadama.jpg")
clinic = SeedHelper::create_clinic(hospital, specializations[0])
SeedHelper::create_doctor(clinic.id, "Ahmed Ali", "doctor1@appointik.com", "123123123", "")

clinic = SeedHelper::create_clinic(hospital, specializations[1])
SeedHelper::create_doctor(clinic.id, "Mohamed Jammal", "doctor2@appointik.com", "123123123", "")

clinic = SeedHelper::create_clinic(hospital, specializations[3])
SeedHelper::create_doctor(clinic.id, "Ebrahim Alaa", "doctor2@appointik.com", "123123123", "")

#==============
hospital = SeedHelper::create_hospital("Lamassa Clinics", "Al Fadl St, Next to Al Riyadh Bank, Jeddah, Saudi Arabia", "+966 12 661 4000", "http://allamssa.com/", "http://allamssa.com/images/phocagallery/thumbs/phoca_thumb_l_01-18.jpg")
clinic = SeedHelper::create_clinic(hospital, specializations[2])
SeedHelper::create_doctor(clinic.id, "Saeed Hassan", "doctor4@appointik.com", "123123123", "")

clinic = SeedHelper::create_clinic(hospital, specializations[4])
SeedHelper::create_doctor(clinic.id, "Abdulaziz Ahmed", "doctor5@appointik.com", "123123123", "")

clinic = SeedHelper::create_clinic(hospital, specializations[5])
SeedHelper::create_doctor(clinic.id, "Farid Mohamed", "doctor6@appointik.com", "123123123", "")

#==============
hospital = SeedHelper::create_hospital("Lamera Clinics", "3964 AR Rawdah, AR Rawdah District, Jeddah, Saudi Arabia", "+966 12 661 4000", "http://www.lamera.clinic/", "http://www.lamera.clinic/wp-content/uploads/2015/12/slder3.png")
clinic = SeedHelper::create_clinic(hospital, specializations[7])
SeedHelper::create_doctor(clinic.id, "Samir Mohamed", "doctor7@appointik.com", "123123123", "")

clinic = SeedHelper::create_clinic(hospital, specializations[3])
SeedHelper::create_doctor(clinic.id, "AbdulRahman Mohamed", "doctor8@appointik.com", "123123123", "")

clinic = SeedHelper::create_clinic(hospital, specializations[8])
SeedHelper::create_doctor(clinic.id, "Ismail Farag", "doctor9@appointik.com", "123123123", "")

#=============

100.times do |index|
  patient = SeedHelper::create_patient("patient"+index.to_s)
  forward_date = Faker::Date.forward(5).strftime
  backward_date = Faker::Date.backward(5).strftime
  today_date = Date.today.strftime


  private_clinics = Clinic.all
  index = Faker::Number.between(0,private_clinics.count-1)
  clinic = private_clinics[index]
  doctor = clinic.doctors.first
  puts "Size : #{private_clinics.count}"
  puts "Index : #{index}"
  puts "Clinic : #{clinic}"
  puts "Doctor : #{doctor}"

  doctor_price = DoctorPrice.find_by_doctor_and_clinic(doctor.id, clinic.id)
  Appointment.create(discount: "0", price: "100", appointment_date: forward_date, state: "confirmed", doctor_price_id: "#{doctor_price.id}", patient_id: "#{patient.id}")
  Appointment.create(discount: "0", price: "100", appointment_date: backward_date, state: "past", doctor_price_id: "#{doctor_price.id}", patient_id: "#{patient.id}")
  Appointment.create(discount: "0", price: "100", appointment_date: today_date, state: "confirmed", doctor_price_id: "#{doctor_price.id}", patient_id: "#{patient.id}")

end

SeedHelper::create_admin("admin@appointik.com", "admin")
