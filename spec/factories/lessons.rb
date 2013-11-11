# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    teacher_id 1
    course_id 1
    note ""
    start_time "2013-11-11 21:34:37"
    end_time "2013-11-11 21:34:37"
  end
end
