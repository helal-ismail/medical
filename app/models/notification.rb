class Notification < ActiveRecord::Base
  belongs_to :user
  enum state: [ :new, :seen]
  
  
  def self.push(user, title, msg)
    
    body = {}
    
    body[:contents] = {:en => msg}
    player_ids = []
    player_ids << user.channel || ''
    body[:include_player_ids] = player_ids
    url = "https://onesignal.com/api/v1/notifications"
    response = Api::NotificationsController.execute_request(url, body.to_json)
    notification = nil
    if response["recipients"].present? && response["recipients"].to_i > 0
      notification = Notificaiton.create(user_id: user.id, title: title, description: msg)
    end
    notification
  end
  
  def as_json(options)
    result = {:id => self.id, :title => self.title, :description => self.description, :state => self.state }
    result
  end
  
end
