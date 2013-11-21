# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base
  attr_accessible :name, :category_id
  belongs_to :category, :class_name => "BookCategory", :foreign_key => "category_id"
end
