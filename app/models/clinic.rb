class Clinic < ActiveRecord::Base
  
  belongs_to :hospital
  belongs_to :specialization
  has_many :doctor_prices
  has_many :appointments, :through => :doctor_prices
  has_many :doctors, :through => :doctor_prices
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode          # auto-fetch coordinates
  
  
  def self.private_clinics
    Clinic.where(:hospital_id => 0)
  end
  
  def self.search_by_pattern(pattern)
    if pattern.blank?  # blank? covers both nil and empty string
      private_clinics
    else
      private_clinics.where('name LIKE ?', "%#{pattern}%")
    end
  end

  def as_json(options)
    super(:only=>[:id, :uid, :name, :address ])
  end
  

end
