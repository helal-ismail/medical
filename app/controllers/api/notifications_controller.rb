class Api::NotificationsController < ApiController
  
  APP_ID ="f1b591e5-4c59-4030-9768-514c430c3738"
  AUTH_KEY = "Basic MGE3NDFiNTQtMWMxNC00MDI5LWFlZTctNmExODY2ODA2ZGEy"
  
  def register_device
    user = User.find(params[:user_id])
    if !user.present?
      render :json => {:msg => "User not found"}, :status => 400 and return
    end
    
    device_type = params[:device_type]
    identifier = params[:identifier]
    body = {"app_id" => APP_ID, "device_type" => device_type, "identifier" => identifier}.to_json
    url = "https://onesignal.com/api/v1/players"
    
    puts "BODY"
    puts body
    
    response = execute_request(url, body)
    
    puts response
    puts "============"
    user.channel = response["id"]
    user.save
    
    render :json => {:msg => "User have been registered, UID : #{user.channel}"}
  end
  
  def send_push
    user = User.find(params[:user_id])
    if !user.present?
      render :json => {:msg => "User not found"}, :status => 400 and return
    end
    
    body = {:app_id => APP_ID}
    
    body[:contents] = {:en => params[:msg]}
    player_ids = []
    player_ids << user.channel
    body[:include_player_ids] = player_ids
    url = "https://onesignal.com/api/v1/notifications"
    response = execute_request(url, body.to_json)
    
    puts response
    
    render :json => response
    
  end
  

  private 
  def execute_request(url, body)
    headers = {'Authorization' => AUTH_KEY , 'Content-Type' => 'application/json'}
    HTTParty.post(url,:body => body, :headers => headers)
    
  end
  
  

  
  
end
