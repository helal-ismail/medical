class Api::NotificationsController < ApiController

  APP_ID ="f1b591e5-4c59-4030-9768-514c430c3738"
  AUTH_KEY = "Basic MGE3NDFiNTQtMWMxNC00MDI5LWFlZTctNmExODY2ODA2ZGEy"


  def user_notifications
    user = User.find(params[:user_id])
    if user.present?
      Notification.set_delivered_to_pending
      counter = user.notifications.where(:state => 1).count
      render :json => {:data => user.notifications.reverse, :pending => counter}
    else
      render :json => {:msg => "User not found"}, :status => 400
    end
  end

  def set_seen
    user = User.find(params[:user_id])
    notification = Notification.find(params[:notification_id])
    if ( user.present? && notification.present? )
      notification.state = 2
      notification.save
      counter = user.notifications.where(:state => 0).count
      render :json => {:msg => "State has been changed to seen", :pending => counter}
    else
      render :json => {:msg => "User or notification not found"}, :status => 400
    end
  end

  def self.execute_request(url, body)
    body[:app_id] = APP_ID

    body[:android_background_layout] = {}
    body[:android_background_layout][:headings_color] = "000000"
    body[:android_background_layout][:contents_color] = "000000"
    body[:small_icon] = "ic_home"
    body[:large_icon] = "ic_notification_green"

    headers = {'Authorization' => AUTH_KEY , 'Content-Type' => 'application/json'}
    HTTParty.post(url,:body => body.to_json, :headers => headers)

  end


  def get_counter
    user = User.find(params[:user_id])
    if user.present?
      counter = user.notifications.where(:state => 0).count
      render :json => {:counter => counter}
    else
      render :json => {:msg => "User or notification not found"}, :status => 400
    end
  end


end
