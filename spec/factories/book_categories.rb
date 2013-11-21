# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book_category do
    name "MyString"
    parent_id ""
  end
end
