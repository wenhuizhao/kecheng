# -*- encoding : utf-8 -*-
class Message < ActiveRecord::Base
  attr_accessible :category_id, :desc, :receiver_id, :sender_id
end
