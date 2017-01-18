class Feedback < ActiveRecord::Base

  belongs_to :user
  belongs_to :appointment

  def self.add_feedback_with_params(params)
    feedback = Feedback.new
    feedback.entity_id = params[:entity_id]
    feedback.entity_type = params[:entity_type]
    feedback.user_id = params[:user_id]
    feedback.comment = params[:comment]
    feedback.stars = params[:stars]
    feedback.appointment_id = params[:appointment_id]

    feedback.save
    feedback
  end


  def self.get_feedback(type, id)
    result = Feedback.where(:entity_type=>type, :entity_id => id)
    result
  end

  def as_json(options)
      # super(:only => [:comment, :stars, :user_id])
      result = {:id => self.id, :comment => self.comment, :stars => self.stars,
                :user_id => self.user_id, :user_name => self.user.name, :user_image => self.user.img_url || '' ,:date => self.created_at.strftime('%Y-%m-%d')}
  end

end
