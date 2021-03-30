require 'rails_helper'

RSpec.describe 'User Dashboard Viewing Party Section' do
  describe 'as an authenticated user' do
    describe 'friends section' do
      it 'shows header' do
        login_user
        visit dashboard_path

        within('#friends') do
          header_text = page.find('.dashboard-header').text
          expect(header_text).to have_content('Friends')
        end
      end

      it 'shows a list of my added friends' do
        login_user
        friend_1 = User.find(create(:friendship, user: @user).friend_id)
        friend_2 = User.find(create(:friendship, user: @user).friend_id)
        visit dashboard_path

        within('#friend-list') do
          friend_elements = page.all('.friend')
          expect(friend_elements.size).to eq(2)
        end
      end

      it 'shows no-friends message if I am all alone' do
        login_user
        visit dashboard_path

        within('#friend-list') do
          friend_elements = page.all('.friend')
          expect(friend_elements.size).to eq(0)
          expect(page).to have_content('You currently have no friends.')
        end
      end

      describe 'adding a friend' do
        it 'allows me to add a friend by email' do
          login_user
          new_friend = create(:user)
          visit dashboard_path

          within('#friends') do
            fill_in :friend_email, with: new_friend.email
            click_button 'Add Friend'
          end

          expect(current_path).to eq(dashboard_path)

          within('#friend-list') do
            friend_elements = page.all('.friend')
            expect(friend_elements.size).to eq(1)
            expect(friend_elements.first.text).to eq(new_friend.email)
          end
        end

        it 'displays an error message if the email entered does not exist in the app' do
          login_user
          visit dashboard_path

          within('#friends') do
            fill_in :friend_email, with: 'fake@example.com'
            click_button 'Add Friend'
          end

          expect(current_path).to eq(dashboard_path)
          expect(page).to have_content('Your friend cannot be found. Are you sure they exist?')
        end

        it 'displays an error message if the friend save fails' do
          login_user
          new_friend = create(:user)
          allow_any_instance_of(Friendship).to receive(:save).and_return(nil)
          visit dashboard_path

          within('#friends') do
            fill_in :friend_email, with: new_friend.email
            click_button 'Add Friend'
          end

          expect(current_path).to eq(dashboard_path)
          expect(page).to have_content('Your friend could not be saved.')
        end
      end
    end
  end

  def login_user
    @user = create(:user)
    perform_login(@user)
  end
end
