# -*- encoding : utf-8 -*-
class Category < ActiveRecord::Base
  attr_accessible :name, :display_order
  def self.display_order ids
    Category.find(ids).sort_by{|c| c.display_order}.map(&:id)
  end
end
