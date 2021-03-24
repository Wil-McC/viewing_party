require 'rails_helper'

RSpec.describe 'Log out process' do
  describe 'on the welcome page' do
    it 'there is no link if user is not logged in' do
      visit root_path
      expect(page).to_not have_link('Log Out')
    end

    it 'displays a logout link if user is logged in' do
      user = User.create(email: 'foo@example.com', password: 'password')

      # Log the user in
      visit login_path
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Log In'
      expect(current_path).to eq(dashboard_index_path)

      # Log the user out
      visit root_path

      expect(page).to have_link('Log Out')
      click_link('Log Out')

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You have been logged out')
      expect(page).to_not have_link('Log Out')
    end
  end
end
