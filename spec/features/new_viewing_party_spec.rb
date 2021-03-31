require 'rails_helper'

RSpec.describe 'creating a new viewing party' do
  describe 'happy path' do
    it 'displays the email of the logged in user' do
      user = create(:user)

      perform_login(user)

      visit new_party_path

      expect(page).to have_content("Welcome #{user.email}")
    end

    it 'displays a form with duration of party' do

      movie = create(:movie)

      require "pry"; binding.pry

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


      perform_login(user_1)

      visit new_party_path

      # fill_in 'party[start_time]', with: '20220101\t0315'
      fill_in 'party[start_time]', with: '20220101111'
      fill_in 'party[duration]', with: 190

      within("#friend-#{friendship_1.friend_id}") do
        page.check
      end

      within("#friend-#{friendship_3.friend_id}") do
        page.check
      end

      save_and_open_page

      click_on 'Create Party'

    end


  end

  describe 'sad path' do
    it 'does not allow a user to enter a duration shorter than the movie length' do

    end

    it 'does not allow a suer to enter a start date prior to the current date' do

    end
  end


end
