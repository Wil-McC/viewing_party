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
      it 'shows header' do
        visit dashboard_path

        within('#friends') do
          header_text = page.find('.dashboard-header').text
          expect(header_text).to have_content('Friends')
        end
      end

      it 'shows a list of my added friends' do
        friend_1 = User.find(create(:friendship, user: @user).friend_id)
        friend_2 = User.find(create(:friendship, user: @user).friend_id)
        visit dashboard_path

        within('#friend-list') do
          friend_elements = page.all('.friend')
          expect(friend_elements.size).to eq(2)
        end
      end

      it 'shows no-friends message if I am all alone' do
        visit dashboard_path

        within('#friend-list') do
          friend_elements = page.all('.friend')
          expect(friend_elements.size).to eq(0)
          expect(page).to have_content('You currently have no friends.')
        end
      end

      describe 'adding a friend' do
        it 'allows me to add a friend by email' do
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
          visit dashboard_path

          within('#friends') do
            fill_in :friend_email, with: 'fake@example.com'
            click_button 'Add Friend'
          end

          expect(current_path).to eq(dashboard_path)
          expect(page).to have_content('Your friend cannot be found. Are you sure they exist?')
        end

        it 'displays an error message if the friend save fails' do
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

    describe 'viewing parties section' do
      it 'shows header' do
        visit dashboard_path

        within('#viewing-parties') do
          header_text = page.find('.dashboard-header').text
          expect(header_text).to have_content('Viewing Parties')
        end
      end

      xit 'shows partes I am hosting' do
        party_1 = create(:party, user: @user)
        party_2 = create(:party, user: @user)
        visit dashboard_path

        within('#viewing-party-list') do
          party_elements = page.all('.viewing-party-card')
          expect(party_elements.size).to eq(2)
        end
      end

      it 'shows correct info for a hosting card' do
        # TODO mon start here
        hosted_party = create(:party, user: @user)
        movie = hosted_party.movie
        invitee_1 = create(:user)
        invitee_2 = create(:user)
        hosted_party.invitees << Invitee.new(party_id: hosted_party.id, user_id: invitee_1.id)
        hosted_party.invitees << Invitee.new(party_id: hosted_party.id, user_id: invitee_2.id)
        visit dashboard_path

        within('.viewing-party-card') do
          # Movie title, which is a link to it's show apge
          link = page.find(:css, "a[href='#{movie_path(movie)}']")
          expect(link.text).to eq(movie.name)

          # Date and time of event
          expect(page).to have_content(hosted_party.start_time.to_date.to_s)
          expect(page).to have_content(hosted_party.start_time.to_time.to_s)

          # That I am the host
          expect(page).to have_content('Hosting')

          # List of friends invited
          expect(page).to have_content(invitee_1.name)
          expect(page).to have_content(invitee_2.name)
        end
      end

      xit 'shows correct info for an invitee card' do
        hosted_party = create(:party, user: @user)
        visit dashboard_path

        within('#viewing-party-card') do
        end
      end

      xit 'shows parties I am invited to' do

      end

      xit 'shows hosting and invited parties at the same time' do

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
