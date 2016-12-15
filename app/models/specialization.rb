class Specialization < ActiveRecord::Base
  
  def as_json(options=nil)
    super(:only => [:id, :name])
    result = {:id => self.id, :name=> self.name, :image_url => "images/"+self.image_url}
  end
  
end
