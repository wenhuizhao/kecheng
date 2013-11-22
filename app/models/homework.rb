class Homework < ActiveRecord::Base
  attr_accessible :lesson_id, :end_time, :enjoin
  belongs_to :lesson
end
