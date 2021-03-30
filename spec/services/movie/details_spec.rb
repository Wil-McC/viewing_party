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
        end
      end
    end
  end
end
