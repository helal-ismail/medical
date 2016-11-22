class Doctor < User
  has_many :clinics, :through => :doctor_prices
  has_many :appointments, :through => :doctor_prices
  
  
  def as_json(options)
    super(:only => [:id, :uid, :name])
  end
  
end
