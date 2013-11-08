class StudentHomework < ActiveRecord::Base
  attr_accessible :homework_id, :status, :student_id
end
