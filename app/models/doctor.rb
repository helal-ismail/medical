class Doctor < User
  has_many :doctor_prices
  has_many :clinics, :through => :doctor_prices
  has_many :appointments, :through => :doctor_prices
  has_many :feedbacks

  def self.search_by_pattern(pattern)
    if pattern.blank?  # blank? covers both nil and empty string
      all
    else
      where('name LIKE ?', "%#{pattern}%")
    end
  end

  def as_json(options)
    #super(:only => [:id, :uid, :name])
    result = {:id => self.id, :name => self.name, :description => self.description || ''}

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

      feedbacks = Feedback.get_feedback("Doctor", self.id)

      if feedbacks.present?
        rating = 0
        feedbacks.each do |f|
          rating += f.stars
        end

        rating = rating.to_f / feedbacks.length
        rating = number_with_precision(rating, :precision => 2)

        result[:feedbacks] = feedbacks
        result[:total_rate] = rating
      end

    end
    return result
  end

end
