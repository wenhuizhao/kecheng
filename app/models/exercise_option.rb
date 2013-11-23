class ExerciseOption < ActiveRecord::Base
  attr_accessible :exercise_id, :name
  belongs_to :exercise
end
