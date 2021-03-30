require 'rails_helper'

RSpec.describe 'User dashboard' do
  describe 'as an authenticated user' do
    it 'shows welcome message' do
      login_user
      visit dashboard_path
      expect(page).to have_content("Welcome #{@user.email}!")
    end

    it 'shows a button to discover movies' do
      login_user
      visit dashboard_path

      expect(page).to have_button('Discover Movies')
      click_button 'Discover Movies'
      expect(current_path).to eq discover_path
    end
  end

  describe 'as a non-authenticated user' do
    it 'redirects to homepage with a flash message' do
      visit dashboard_path

      expect(current_path).to eq root_path
      expect(page).to have_content('You must be logged in to access this section')
    end
  end

  def login_user
    @user = create(:user)
    perform_login(@user)
  end
end
