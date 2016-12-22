class Notification < ActiveRecord::Base
  belongs_to :user
  enum state: [ :new, :seen]
  
end
