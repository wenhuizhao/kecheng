# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :users_message, :class => 'UsersMessages' do
    user_id 1
    message_id 1
    status "MyString"
  end
end
