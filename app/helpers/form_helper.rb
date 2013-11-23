module FormHelper
  def setup_exercise(exercise)
    5.times {exercise.options.build }
    exercise
  end
end