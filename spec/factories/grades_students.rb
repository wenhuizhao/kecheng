# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :grades_student, :class => 'GradesStudents' do
    grade_num ""
    class_num 1
    student_id "MyString"
  end
end
