require 'rails_helper'

RSpec.describe 'creating a new viewing party' do
  describe 'happy path' do
    it 'displays the email of the logged in user' do
      VCR.use_cassette('rambo_movie_show_page') do
        user = create(:user)
        login_and_visit_path(user)

        expect(page).to have_content("Welcome #{user.email}")
      end
    end

    it 'preloads with movie title and duration' do
      VCR.use_cassette('rambo_movie_show_page') do
        user = create(:user)

        login_and_visit_path(user)
        expect(current_path).to eq(new_party_path)

        expect(page.find('#movie-title').text).to eq('Rambo')
        expect(page.find_field('party[duration]').value).to eq('92')
      end
    end

    it "saves a viewing party and displays it on the user's show page" do
      VCR.use_cassette('rambo_movie_show_page') do
        user_1 = create(:user)

        login_and_visit_path(user_1)
        expect(current_path).to eq(new_party_path)

        fill_in 'party[start_time]', with: '20220101\t0315'
        fill_in 'party[duration]', with: 190

        click_on 'Create Party'
        expect(current_path).to eq(dashboard_path)

        within('#viewing-party-list') do
          party_elements = page.all('.viewing-party-card') #does this test anything?
          expect(page).to have_content('Rambo')
          expect(page).to have_content('Nobody is invited to this viewing party')
        end
      end
    end

    it "invites friends to the viewing party" do
      VCR.use_cassette('rambo_movie_show_page') do
        user_1 = create(:user)
        user_2 = create(:user)
        user_3 = create(:user)
        user_4 = create(:user)
        user_5 = create(:user)

        friendship_1 = create(:friendship, user: user_1, friend: user_2)
        friendship_2 = create(:friendship, user: user_1, friend: user_3)
        friendship_3 = create(:friendship, user: user_1, friend: user_4)
        friendship_4 = create(:friendship, user: user_1, friend: user_5)

        login_and_visit_path(user_1)
        expect(current_path).to eq(new_party_path)

        fill_in 'party[start_time]', with: '20220101\t0315'
        fill_in 'party[duration]', with: 190

        within("#friend-#{friendship_1.friend_id}") do
          page.check
        end

        within("#friend-#{friendship_3.friend_id}") do
          page.check
        end

        click_on 'Create Party'
        expect(current_path).to eq(dashboard_path)

        within('#viewing-party-list') do
          expect(page).to have_content('Rambo')
          expect(page).to have_content("#{user_2.email}")
          expect(page).to have_content("#{user_4.email}")
          expect(page).to_not have_content("#{user_3.email}")
          expect(page).to_not have_content("#{user_5.email}")
        end
      end
    end

    it "shows a friend the viewing parties they are invited to" do
      VCR.use_cassette('rambo_movie_show_page') do
        user_1 = create(:user)
        user_2 = create(:user)

        friendship_1 = create(:friendship, user: user_1, friend: user_2)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
        visit movie_path(7555)
        click_on('Create Viewing Party for Movie')
        expect(current_path).to eq(new_party_path)

        fill_in 'party[start_time]', with: '20220101\t0315'
        fill_in 'party[duration]', with: 190

        within("#friend-#{friendship_1.friend_id}") do
          page.check
        end

        click_on 'Create Party'

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

        visit dashboard_path

        within('#viewing-party-list') do
          expect(page).to have_content('Rambo')
          expect(page).to have_content("Hosted by: #{user_1.email}")
          expect(page).to have_content("#{user_2.email}")
        end
      end
    end


    it "does not show a friend viewing parties they are not invited to" do
      VCR.use_cassette('rambo_movie_show_page') do
        user_1 = create(:user)
        user_2 = create(:user)
        user_3 = create(:user)

        friendship_1 = create(:friendship, user: user_1, friend: user_2)
        friendship_2 = create(:friendship, user: user_1, friend: user_3)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
        visit movie_path(7555)
        click_on('Create Viewing Party for Movie')
        expect(current_path).to eq(new_party_path)

        fill_in 'party[start_time]', with: '20220101\t0315'
        fill_in 'party[duration]', with: 190

        within("#friend-#{friendship_1.friend_id}") do
          page.check
        end

        click_on 'Create Party'

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_3)

        visit dashboard_path

        within('#viewing-party-list') do
          expect(page).to have_content('You currently have no viewing parties.')
          expect(page).to_not have_content("#{user_1.email}")
          expect(page).to_not have_content("#{user_2.email}")
        end
      end
    end
  end

  describe 'sad path' do
    it 'does not allow a user to enter a duration shorter than the movie length' do
      VCR.use_cassette('rambo_movie_show_page') do
        user_1 = create(:user)

        login_and_visit_path(user_1)
        expect(current_path).to eq(new_party_path)

        fill_in 'party[start_time]', with: '20220101\t0315'
        fill_in 'party[duration]', with: 20

        click_on 'Create Party'
        expect(current_path).to eq(dashboard_path)
      end
    end
  end

  def login_and_visit_path(user)
    perform_login(user)
    # Hard coding a movie's API ID
    # TODO how to do this another way, not relying on this hard-coded id?
    visit movie_path(7555)
    click_on('Create Viewing Party for Movie')
  end
end
