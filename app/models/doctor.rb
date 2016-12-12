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
    super(:only => [:id, :uid, :name])
  end

end
