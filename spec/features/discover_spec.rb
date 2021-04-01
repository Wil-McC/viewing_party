require 'rails_helper'

RSpec.describe 'Discover page' do
  describe 'as an authenticated user' do
    before :each do
      @user = create(:user)
      perform_login(@user)
    end
    it 'shows discover page with welcome message' do
      visit discover_path

      expect(page).to have_content("Welcome #{@user.email}")
    end
    it 'has a top rated button that populates results on click' do
      visit discover_path

      VCR.use_cassette('movies') do
        click_on 'Top Rated'

        expect(current_path).to eq(movies_path)

        within('#results') do
          expect(page).to have_selector('p', count: 40)
          expect(page).to have_link('The Green Mile - 8.5')
          expect(page).to have_link('The Godfather - 8.7')
          expect(page).to have_link('City of God - 8.4')
        end
      end
    end
    it 'has a trending weekly button that populates results on click' do
      visit discover_path

      VCR.use_cassette('trending_weekly') do
        click_on 'Trending This Week'

        expect(current_path).to eq(movies_path)

        within('#results') do
          expect(page).to have_selector('p', count: 40)
        end
      end
    end
    it "goes to movie show page on title click" do
      visit discover_path

      VCR.use_cassette('trending_weekly') do
        click_on 'Trending This Week'

        within('#results') do
          click_on "Zack Snyder's Justice League - 8.6"

          expect(current_path).to eq(movie_path(791373))
        end
        expect(page).to_not have_content("Where to Watch Zack Snyder's Justice League")
        expect(page).to_not have_link('View options to watch this movie legally')
      end
    end
    it "has a search field that returns max 40 matching results on submit" do
      VCR.use_cassette('rambo_search') do
        visit discover_path

        fill_in :query, with: 'rambo'
        click_button 'Search'

        within('#results') do
          expect(current_path).to eq(movies_path)
          expect(page).to have_selector('p', count: 40)
        end
      end
    end
  end

  describe 'sad paths' do
    before :each do
      @user = create(:user)
      perform_login(@user)
    end
    xit "shows flash message when top 40 call fails - 404" do
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MDB_KEY']}&page=1")
        .with(
          headers: {
            'api_key': ENV['MDB_KEY']
          })
        .to_return(status: 404, body: '', headers: {})

      visit discover_path

      click_on 'Top Rated'

      expect(current_path).to eq(discover_path)
      expect(page).to have_content('Error loading results')
    end
  end

  describe 'as a non-authenticated user' do
    it 'redirects to homepage with a flash message' do
      visit discover_path

      expect(current_path).to eq root_path
      expect(page).to have_content('You must be logged in to access this section')
    end
  end
end
