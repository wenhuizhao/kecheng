# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :period do
    full_name "MyString"
    start_year "MyString"
    end_year "MyString"
    desc "MyString"
    is_current false
  end
end
