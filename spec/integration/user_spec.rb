require 'spec_helper'

describe 'user' do
  it "sign up" do
    visit('/users/sign_up')
    fill_in('user_email', :with => 'test@test.com')
    fill_in('user_password', :with => 'testtest')
    fill_in('user_password_confirmation', :with => 'testtest')
    click_on('Sign up')
    expect(page).to have_content('Home')
  end
end
    
