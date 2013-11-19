# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :grades_course, :class => 'GradesCourses' do
    grade_num 1
    class_num "MyString"
    course_id 1
    is_open false
  end
end
