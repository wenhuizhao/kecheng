# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :grade do
    grade_num 1
    class_num 1
    full_name "MyString"
    period "MyString"
  end
end
