require 'rails_helper'

RSpec.describe 'registration form' do
  it 'clicking on registration link leads to registration page' do
    visit root_path

    click_on 'Register'

    expect(current_path).to eq(new_user_path)
  end

  it 'submits and creates on submit' do
    visit new_user_path

    save_and_open_page
    fill_in 'email', with: 'beeps@beep.org'
    fill_in 'password', with: 'secretbeeps'


    click_on 'Register'
  end
end
