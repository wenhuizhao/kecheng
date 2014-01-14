class ExerciseOption < ActiveRecord::Base
  OPTION_NUM = ['A', 'B', 'C', 'D', 'E', 'F']
  attr_accessible :exercise_id, :name
  belongs_to :exercise

end
