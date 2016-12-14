class Patient < User
  has_many :appointments

  def self.search_by_pattern(pattern)
    if pattern.blank?  # blank? covers both nil and empty string
      all
    else
      where('name LIKE ?', "%#{pattern}%")
    end
  end

  def as_json(options)
    super(:only => [:id, :name])
  end
end
