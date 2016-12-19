# Unified PASSWORD
password = "123456"
specializations = Specialization.all


10.times do |index|
  hospital = FakerHelper.create_hospital
  specializations.each do |spec|
    clinic = Clinic.create(name: "#{spec.name}", hospital_id: hospital.id, address: hospital.address, specialization_id: "#{spec.id}")
    3.times.each do
      FakerHelper.create_doctor(clinic.id)
    end
  end
end
  

specializations.each do |spec|
  2.times do
    FakeHelper.create_clinic(spec)
  end
end

100.times do |index|
  patient = FakerHelper.create_patient
  forward_date = Faker::Date.forward(15).strftime
  backward_date = Faker::Date.backward(15).strftime
  
  private_clinics = Clinic.private_clinics
  index = Faker::Number.between(0,private_clinics.count-1)
  clinic = private_clinics[index]
  doctor = clinic.doctors.first
  DoctorPrice.find
  Appointment.create(discount: "0", price: "100", appointment_date: forward_date, state: "confirmed", doctor_price_id: "#{doctor_price.id}", patient_id: "#{patient.id}")

end

