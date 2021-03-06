class Doctor < User
  include ActionView::Helpers::NumberHelper
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

  def clinics
    clinics = []
    self.doctor_prices.each do |doctor_price|
      clinics << doctor_price.clinic
    end
    return clinics
  end

  def appointments_by_period(period_start, period_end)
    date_start = Date.parse(period_start)
    date_end = Date.parse(period_end)
    result = []
    total = 0
    while (date_start < date_end)
      appointments_count = self.appointments_by_date(date_start).count
      total = total + appointments_count
      record = {:date => date_start , :count => appointments_count}
      result << record
      date_start = date_start+1
    end
    {:doctor_id =>self.id, :doctor_name => self.name,  :total => total, :data => result}
#    self.appointments.where("appointment_date between ? AND ?", period_start, periond_end)

  end


  def appointments_by_date(date)
    self.appointments.where(:appointment_date => date)
  end



  def as_json(options)
    #super(:only => [:id, :uid, :name])
    result = {:id => self.id, :name => self.name, :description => self.description || '', :total_rate => "0.0", :feedbacks=>[], :img_url => self.img_url || '', :img_base64 => self.img_base64 || '' }


    feedbacks = Feedback.get_feedback("Doctor", self.id)

    if feedbacks.present?
      rating = 0
      feedbacks.each do |f|
        rating += f.stars
      end

      rating = rating.to_f / feedbacks.length
      rating = number_with_precision(rating, :precision => 2)

      result[:total_rate] = rating
    end

    if options[:detailed_info].present?
      clinics_result = []
      self.clinics.each do |clinic|
        sub_result = {}
        sub_result[:clinic_id] = clinic.id
        sub_result[:clinic_name] = clinic.name

        sub_result[:hospital_id] = -0
        sub_result[:hospital_name] = ""
        if clinic.hospital.present?
         sub_result[:hospital_id] = clinic.hospital.id
         sub_result[:hospital_name] = clinic.hospital.name
        end
        clinics_result << sub_result
      end
      result[:clinics] = clinics_result

      if feedbacks.present?
        result[:feedbacks] = feedbacks
      end

    end
    return result
  end

end
