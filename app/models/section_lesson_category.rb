# -*- encoding : utf-8 -*-
class SectionLessonCategory < ActiveRecord::Base
  attr_accessible :section_id, :lesson, :category_id
  belongs_to :section
  belongs_to :category
end
