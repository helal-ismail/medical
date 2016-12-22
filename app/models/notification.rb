class Notification < ActiveRecord::Base
  belongs_to :user
  enum state: [ :new, :seen]
  
  def as_json(options)
    result = {:id => self.id, :title => self.title, :description => self.description, :state => self.state }
    result
  end
  
end
