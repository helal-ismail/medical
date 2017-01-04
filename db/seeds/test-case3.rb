require_relative "libs/faker_helper"

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


10.times do |index|
  hospital = FakerHelper::create_hospital
  specializations.each do |spec|
    clinic = Clinic.create(name: "#{spec.name}", hospital_id: hospital.id, address: hospital.address, specialization_id: "#{spec.id}")
    3.times.each do
      FakerHelper::create_doctor(clinic.id)
    end
  end
end
  

specializations.each do |spec|
  2.times do
    FakerHelper.create_clinic(spec)
  end
end

100.times do |index|
  patient = FakerHelper::create_patient("patient"+index.to_s)
  forward_date = Faker::Date.forward(15).strftime
  backward_date = Faker::Date.backward(15).strftime
  
  private_clinics = Clinic.private_clinics
  index = Faker::Number.between(0,private_clinics.count-1)
  clinic = private_clinics[index]
  doctor = clinic.doctors.first
  doctor_price = DoctorPrice.find_by_doctor_and_clinic(doctor.id, clinic.id)
  Appointment.create(discount: "0", price: "100", appointment_date: forward_date, state: "confirmed", doctor_price_id: "#{doctor_price.id}", patient_id: "#{patient.id}")

end

