class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification
  enum state: [:delivered, :pending, :seen ]


  def self.push(entity_type, entity_id, user, title, msg, msg_ar)

    body = {}

    body[:contents] = {:en => msg, :ar => msg_ar}
    body[:data] = {:entity_type => entity_type, :entity_id => entity_id}
    
    player_ids = []
    player_ids << user.channel || ''
    body[:include_player_ids] = player_ids
    url = "https://onesignal.com/api/v1/notifications"
    response = Api::NotificationsController.execute_request(url, body)
    notification = nil
    if response["recipients"].present? && response["recipients"].to_i > 0
      notification = create(user_id: user.id, title: title, description_en: msg, description_ar: msg_ar, entity_type: entity_type, entity_id: entity_id)
    end
    notification
  end

  def self.set_delivered_to_pending
    Notification.where(:state => 0).update_all(state: 1)
  end

  def as_json(options)
    result = {:id => self.id, :title => self.title, :state => self.state,
              :entity_type => self.entity_type, :entity_id => self.entity_id,
              :date => self.created_at.strftime('%Y-%m-%d'), :time => self.created_at.strftime('%r')}

     if (user.local == "en")
       result[:description] = self.description_en
     else
       result[:description] = self.description_ar
     end
    result
  end

end
