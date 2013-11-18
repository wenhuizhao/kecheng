# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stu_grade_course, :class => 'StuGradeCourses' do
    score "MyString"
    note "MyString"
  end
end
