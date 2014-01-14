# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student_homeworks_exercise, :class => 'StudentHomeworksExercises' do
    student_homework_id 1
    exercise_id 1
    canvas "MyText"
  end
end
