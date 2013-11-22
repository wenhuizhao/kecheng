# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student_course do
    grades_course_id 1
    student_id 1
    note "MyString"
    score "MyString"
  end
end
