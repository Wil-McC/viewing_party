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
          expect(page).to have_content('Friends')
          friend_elements = page.all('.friend')
          expect(friend_elements.size).to eq(2)
        end
      end

      it 'shows no-friends message if I am all alone' do
        visit dashboard_path

        within('#friends') do
          expect(page).to have_content('Friends')
          friend_elements = page.all('.friend')
          expect(friend_elements.size).to eq(0)
          expect(page).to have_content('You currently have no friends.')
        end
      end

      describe 'adding a friend' do
        it 'allows me to add a friend by email' do
          visit dashboard_path

          within('#friends') do
            within('#form-add-friend') do
              expect(page).to have_field('friend_email')
              expect(page).to have_button('Add Friend')
            end
          end
        end

        it 'displays an error message if the email entered does not exist in the app' do
          visit dashboard_path

          within('#friends') do
            fill_in :friend_email, with: 'fake@example.com'
            click_button 'Add Friend'
          end

          expect(current_path).to eq(dashboard_path)
          expect(page).to have_content('Your friend cannot be found. Are you sure they exist?')
        end
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
