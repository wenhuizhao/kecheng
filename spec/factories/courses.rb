# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name "MyString"
    desc "MyString"
    is_open false
    stu_class_id 1
  end
end
