# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exercise_text do
    content "MyText"
    book_id 1
    section "MyString"
    page 1
  end
end
