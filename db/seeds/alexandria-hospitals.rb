# Seed Hospitals
Hospital.create(name: 'German Hospital', address: 'Qesm AR Ramel سابا محطة باشا, Fleming, Qism El-Raml, Alexandria Governorate', uid: '1', phone: '123123123', website: 'www.hospital.com', email: 'contact@hospital.com')
Hospital.create(name: 'Louran Hospital', address: 'St. - Louran, 13 Shaarawy, San Stifano, Qesm AR Ramel, Alexandria Governorate', uid: '2', phone: '123123123', website: 'www.hospital.com', email: 'contact@hospital.com')
#Hospital.create(name: 'ICC Hospital', address: 'Izbat Saed, Qesm Sidi Gaber, Alexandria Governorate', uid: '3', phone: '123123123', website: 'www.hospital.com', email: 'contact@hospital.com')
#Hospital.create(name: 'Agial Hospital', address: 'Khalf Fared Lyan, Mustafa Kamel WA Bolkli, Qesm Sidi Gaber, Alexandria Governorate', uid: '4', phone: '123123123', website: 'www.hospital.com', email: 'contact@hospital.com')
#Hospital.create(name: 'Victoria Hospital', address: 'Fleb Glad, Al Qasaei Qebli, Qesm AR Ramel, Alexandria Governorate', uid: '5', phone: '123123123', website: 'www.hospital.com', email: 'contact@hospital.com')
#Hospital.create(name: 'Alexandria International Hospital', address: '35 Mohamed Bahaa Eldin Al Ghatwary, Qism Sidi Gabir, الإسكندرية
#3', uid: '6', phone: '123123123', website: 'www.hospital.com', email: 'contact@hospital.com')
#Hospital.create(name: 'Royal Hospital', address: 'Abu an Nawatir, Qesm Sidi Gaber, Alexandria Governorate
#', uid: '7', phone: '123123123', website: 'www.hospital.com', email: 'contact@hospital.com')
#Hospital.create(name: 'El Shrouk Hospital', address: 'Address: 9 شارع مصطفى فهمي، Qism El-Raml, Alexandria Governorate', uid: '8', phone: '123123123', website: 'www.hospital.com', email: 'contact@hospital.com')


Hospital.all.each do |hospital|
  Clinic.create(name: 'عيادة القلب', uid: hospital.id.to_s+'1', hospital_id: hospital.id, address: hospital.address)
  Clinic.create(name: 'عيادة العظام', uid: hospital.id.to_s+'2', hospital_id: hospital.id, address: hospital.address)
  Clinic.create(name: 'عيادة الباطنة', uid: hospital.id.to_s+'3', hospital_id: hospital.id, address: hospital.address)
  Clinic.create(name: 'عيادة العيون', uid: hospital.id.to_s+'4', hospital_id: hospital.id, address: hospital.address)
end

