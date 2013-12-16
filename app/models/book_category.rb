# -*- encoding : utf-8 -*-
class BookCategory < ActiveRecord::Base
  attr_accessible :name, :parent_id
  belongs_to :parent, :class_name => "BookCategory", :foreign_key => "parent_id"
  has_many :categories, :class_name => "BookCategory", :foreign_key => "parent_id"
  has_many :books

  scope :for_course, -> { where('parent_id is not null') }

  def full_name
    self.parent.nil? ? self.name : "#{self.parent.full_name}-#{self.name}"
  end
end
