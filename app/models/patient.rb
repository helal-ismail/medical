class Patient < User
  has_many :appointments

  def self.search_by_pattern(pattern)
    if pattern.blank?  # blank? covers both nil and empty string
      all
    else
      where('name LIKE ?', "%#{pattern}%")
    end
  end
  
  def self.search_by_pattern_and_doctor(pattern, doctor)
    patients = []
    patient_ids = {}
    doctor.appointments.each do |appointment|
      unless patient_ids["#{appointment.patient.id}"].present?
        patients << appointment.patient
      end    
    end
    
    patients
  end

  def as_json(options)
    super(:only => [:id, :name])
  end
end
