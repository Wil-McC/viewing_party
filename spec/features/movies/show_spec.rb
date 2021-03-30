require 'rails_helper'

RSpec.describe 'Movie details page' do
  describe 'as an authenticated user' do
   xit 'shows a button to create a viewing party for this movie' do

    end

    describe 'movie info' do
      # Name, vote average, runtime, genres, summary
      it 'shows movie name' do
        login_and_visit_path

        within('#info') do
          expect(page).to have_content('Rambo')
        end
      end
    end

    describe 'cast list' do
      # First 10 cast members
    end

    describe 'reviews section' do
      # List all reviews with authors
    end
  end

  describe 'as a non-authenticated user' do
    it 'redirects to homepage with a flash message' do
      visit movie_path(id: 1)

      expect(current_path).to eq root_path
      expect(page).to have_content('You must be logged in to access this section')
    end
  end

  def login_and_visit_path
    @user = create(:user)
    perform_login(@user)
    # Hard coding a movie's API ID
    # TODO how to do this another way, not relying on this hard-coded id?
    visit movie_path(7555)
  end
end