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

    xit 'displays a form with duration of party' do
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

        friendship_3 = create(:friendship, user: user_2, friend: user_4)
        friendship_4 = create(:friendship, user: user_2, friend: user_5)

        login_and_visit_path(user_1)
        expect(current_path).to eq(new_party_path)

        fill_in 'party[start_time]', with: '20220101\t0315'
        # fill_in 'party[start_time]', with: '20220101111'
        fill_in 'party[duration]', with: 190

        within("#friend-#{friendship_1.friend_id}") do
          page.check
        end

        within("#friend-#{friendship_3.friend_id}") do
          page.check
        end

        click_on 'Create Party'

        # TODO what to test now?
      end
    end
  end

  describe 'sad path' do
    xit 'does not allow a user to enter a duration shorter than the movie length' do
    end

    xit 'does not allow a suer to enter a start date prior to the current date' do
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
