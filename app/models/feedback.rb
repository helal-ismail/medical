class Feedback < ActiveRecord::Base
  
  
  def get_feedback(type, id)
    result = Feedback.where(:entity_type=>type, :entity_id => id)
    result
  end
  
end
