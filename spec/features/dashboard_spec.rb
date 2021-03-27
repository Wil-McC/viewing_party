require 'rails_helper'

RSpec.describe 'User dashboard' do
  before :each do
    @user = create(:user)
    perform_login(@user)
  end

  describe 'as an authenticated user' do
    it 'shows welcome message' do
      visit dashboard_path
      expect(page).to have_content("Welcome #{@user.email}!")
    end

    it 'shows a button to discover movies' do
      visit dashboard_path

      expect(page).to have_button('Discover Movies')
      click_button 'Discover Movies'
      expect(current_path).to eq discover_path
    end

    describe 'friends section' do
      it 'shows a list of my added friends' do
        friend_1 = User.find(create(:friendship, user: @user).friend_id)
        friend_2 = User.find(create(:friendship, user: @user).friend_id)
        visit dashboard_path

        within('#friends') do
          friend_elements = page.all('.friend')
          expect(friend_elements.size).to eq(2)
        end
      end

      it 'shows a form to add a friend by email' do
        visit dashboard_path

        within('#friends') do
          expect(page).to have_content('Friends')
          expect(page).to have_selector('#invite-friends') # TODO identify the form's text box
          expect(page).to have_button('Add Friend')
        end
      end

      xit 'shows list of friends if I have any' do

      end

      xit 'shows list of friends if I am all alone' do

      end
    end

    describe 'viewing parties section' do
      xit 'shows partes I am hosting' do

      end

      xit 'shows parties I am invited to' do

      end
    end
  end

  describe 'as a non-authenticated user' do
    xit 'redirects to homepage with a flash message' do
      visit dashboard_path

      expect(current_path).to eq root_path
      expect(page).to have_content('You must be logged in to access this section')
    end
  end
end
