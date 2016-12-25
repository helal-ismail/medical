class Api::NotificationsController < ApiController
  
  APP_ID ="f1b591e5-4c59-4030-9768-514c430c3738"
  AUTH_KEY = "Basic MGE3NDFiNTQtMWMxNC00MDI5LWFlZTctNmExODY2ODA2ZGEy"
  
  
  def user_notifications
    user = User.find(params[:user_id])
    if user.present?
      render :json => {:data => user.notifications}
    else
      render :json => {:msg => "User not found"}, :status => 400
    end
  end

  def self.execute_request(url, body)
    body[:app_id] = APP_ID
    headers = {'Authorization' => AUTH_KEY , 'Content-Type' => 'application/json'}
    HTTParty.post(url,:body => body.to_json, :headers => headers)
    
  end
  
  

  
  
end
