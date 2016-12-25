class Notification < ActiveRecord::Base
  belongs_to :user
  enum state: [ :pending, :seen ]


  def self.push(user, title, msg, msg_ar)

    body = {}

    body[:contents] = {:en => msg, :ar => msg_ar}
    player_ids = []
    player_ids << user.channel || ''
    body[:include_player_ids] = player_ids
    url = "https://onesignal.com/api/v1/notifications"
    response = Api::NotificationsController.execute_request(url, body)
    notification = nil
    if response["recipients"].present? && response["recipients"].to_i > 0
      notification = create(user_id: user.id, title: title, description_en: msg, description_ar: msg_ar)
    end
    notification
  end

  def as_json(options)
    result = {:id => self.id, :title => self.title, :state => self.state }
     if (user.local == "en")
       result[:description] = self.description_en
     else
       result[:description] = self.description_ar
     end
    result
  end

end
