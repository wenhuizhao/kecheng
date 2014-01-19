# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :change_teacher_log do
    prev_teacher_id 1
    curr_teacher_id 1
    admin_Id 1
    grades_course_id 1
  end
end
