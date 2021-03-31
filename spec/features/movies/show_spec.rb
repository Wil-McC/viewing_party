require 'rails_helper'

RSpec.describe 'Movie details page' do
  describe 'as an authenticated user' do
   xit 'shows a button to create a viewing party for this movie' do

    end

    describe 'movie info' do
      # Name, vote average, runtime, genres, summary
      it 'shows movie title, vote average, runtime' do
        VCR.use_cassette('rambo_movie_show_page') do
          login_and_visit_path

          within('#info') do
            expect(page).to have_content('Rambo')
            expect(page).to have_content('6.6')
            expect(page).to have_content('92')
            expect(page).to have_content('Action')
            expect(page).to have_content('Thriller')
          end
        end
      end

      it 'shows movie summary' do
        VCR.use_cassette('rambo_movie_show_page') do
          login_and_visit_path

          within('#info #summary') do
            paragraphs = page.find_all('p')
            expect(paragraphs.size).to eq(1)
            expect(paragraphs[0].text).to include('When governments fail to act on behalf of captive missionaries, ex-Green Beret John James Rambo')
          end
        end
      end
    end

    describe 'cast list' do
      it 'shows first 10 cast members' do
        VCR.use_cassette('rambo_movie_show_page') do
          login_and_visit_path

          within('#info #cast') do
            cast_elements = page.find_all('.cast-member')
            expect(cast_elements.size).to eq(10)
            expect(cast_elements.first.text).to eq('Sylvester Stallone as John Rambo')
            expect(cast_elements.last.text).to eq('Cameron Pearson as Jeff')
          end
          save_and_open_page
        end
      end
    end

    describe 'reviews section' do
      it "shows all reviews" do
        login_and_visit_path

        VCR.use_cassette('rambo_movie_show_page') do
          within('#info #reviews') do
            review_elements = page.find_all('.review')

            expect(review_elements.length).to eq(2)
          end
        end
      end
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
