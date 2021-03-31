require 'rails_helper'
require 'ostruct'

RSpec.describe 'the movieDB api service' do
  describe 'class methods' do
    describe '::details_for' do
      it 'returns ostruct with title, vote average, runtime' do
        VCR.use_cassette('rambo_movie_details') do
          result = TMDBService.details_for(7555)

          expect(result).to be_a(OpenStruct)
          expect(result.title).to eq('Rambo')
          expect(result.vote_average).to eq(6.6)
          expect(result.runtime).to eq(92)
          expect(result.genres).to eq(['Action', 'Thriller'])
          expect(result.summary).to include('When governments fail to act on behalf of captive missionaries, ex-Green Beret John James Rambo')
        end
      end
    end
    describe '::reviews for' do
      it "returns reviews ostruct array" do
        VCR.use_cassette('rambo_7555_reviews') do
          result = TMDBService.reviews_for(7555)

          expect(result.length).to eq(2)
          expect(result.class).to eq(Array)
          expect(result[0][:author]).to eq("JPV852")
        end
      end
    end
  end
end
