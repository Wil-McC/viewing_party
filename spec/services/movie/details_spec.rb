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
<<<<<<< HEAD
    describe '::reviews for' do
      it "returns reviews ostruct array" do
        VCR.use_cassette('rambo_7555_reviews') do
          result = TMDBService.reviews_for(7555)

          expect(result.length).to eq(2)
          expect(result.class).to eq(Array)
          expect(result[0][:author]).to eq("JPV852")
=======

    describe '::cast_for' do
      it 'returns array or ostruct, each with actor and character names' do
        VCR.use_cassette('rambo_movie_cast') do
          result = TMDBService.cast_for(7555, 10)

          expect(result).to be_an(Array)
          first = result.first
          last = result.last
          expect(first).to be_an(OpenStruct)
          expect(last).to be_an(OpenStruct)

          expect(first.actor).to eq('Sylvester Stallone')
          expect(first.character).to eq('John Rambo')

          expect(last.actor).to eq('Cameron Pearson')
          expect(last.character).to eq('Jeff')
>>>>>>> 69328a186e080bde187ca1f505c149e2b5c93191
        end
      end
    end
  end
end
