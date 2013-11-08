# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student_homework do
    student_id 1
    homework_id 1
    status "MyString"
  end
end
