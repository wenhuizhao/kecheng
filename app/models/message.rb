# -*- encoding : utf-8 -*-
class Message < ActiveRecord::Base
  attr_accessible :category_id, :desc, :receiver_id, :sender_id, :is_open, :type_name, :parent_id
  
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  
  validates :desc, :type_name, :sender_id, presence: true

  scope :global_messages, -> { where(type_name: '群') }
  scope :messages_of, -> (user) { where(receiver_id: user.id) }

  def self.all_for(user)
    messages_of(user) + global_messages
  end
end
