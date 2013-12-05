# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :section do
    name "MyString"
    parent_id 1
    book_id 1
  end
end
