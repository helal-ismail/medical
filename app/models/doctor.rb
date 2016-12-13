class Doctor < User
  has_many :doctor_prices
  has_many :clinics, :through => :doctor_prices
  has_many :appointments, :through => :doctor_prices

  def self.search_by_pattern(pattern)
    if pattern.blank?  # blank? covers both nil and empty string
      all
    else
      where('name LIKE ?', "%#{pattern}%")
    end
  end

  def as_json(options)
    #super(:only => [:id, :uid, :name])
    result = {:id => self.id, :uid => self.uid, :name => self.name, :description => self.description}
    
    if options[:detailed_info].present?
      clinics_result = []
      self.clinics.each do |clinic|
        sub_result = {}
        sub_result[:clinic_id] = clinic.id
        sub_result[:clinic_name] = clinic.name
        sub_result[:hospital_id] = clinic.hospital.id
        sub_result[:hospital_name] = clinic.hospital.name
        clinics_result << sub_result
      end
      result[:clinics] = clinics_result
    end
    return result
  end

end
