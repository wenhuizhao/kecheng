class Course < ActiveRecord::Base
  attr_accessible :desc, :is_open, :name, :stu_class_id
end
