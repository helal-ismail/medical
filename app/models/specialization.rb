class Specialization < ActiveRecord::Base
  
  def as_json(options=nil)
    super(:only => [:id, :name])
  end
  
end
