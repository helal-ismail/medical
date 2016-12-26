class Api::NotificationsController < ApiController

  APP_ID ="f1b591e5-4c59-4030-9768-514c430c3738"
  AUTH_KEY = "Basic MGE3NDFiNTQtMWMxNC00MDI5LWFlZTctNmExODY2ODA2ZGEy"


  def user_notifications
    user = User.find(params[:user_id])
    if user.present?
      counter = user.notifications.where(:state => 1).count
      Notification.set_delivered_to_pending
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
      counter = user.notifications.where(:state => 0)
      render :json => {:msg => "State has been changed to seen", :pending => counter.length}
    else
      render :json => {:msg => "User or notification not found"}, :status => 400
    end
  end

  def self.execute_request(url, body)
    body[:app_id] = APP_ID
    headers = {'Authorization' => AUTH_KEY , 'Content-Type' => 'application/json'}
    HTTParty.post(url,:body => body.to_json, :headers => headers)

  end





end
