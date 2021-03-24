require 'rails_helper'

RSpec.describe 'Login page' do
  it 'displays a form to login with email and password' do
    user = User.create(email: 'foo@example.com', password: 'barbaz')
    visit login_path

    within('#login-form') do
      fill_in('email', with: 'foo@example.com')
      fill_in('password', with: user.password)
      click_button('Log In')
    end

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Welcome #{user.email}!")
  end

  it "invalid credentials don't work" do
    user = User.create(email: 'foo@example.com', password: 'barbaz')
    visit login_path

    within('#login-form') do
      fill_in('email', with: 'foo@example.com')
      fill_in('password', with: 'NotMyPassword')
      click_button('Log In')
    end

    expect(current_path).to eq(login_path)
    expect(page).to have_content('You entered bad credentials and you should feel bad')
  end
end
