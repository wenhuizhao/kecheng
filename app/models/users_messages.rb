class UsersMessages < ActiveRecord::Base
  attr_accessible :message_id, :status, :user_id
end
