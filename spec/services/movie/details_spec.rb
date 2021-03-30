require 'rails_helper'
require 'ostruct'

RSpec.describe 'the movieDB api service' do
  describe 'class methods' do
    describe '::details_for' do
      it 'returns ostruct with title' do
        VCR.use_cassette('rambo_movie_details') do
          result = TMDBService.details_for(7555)

          expect(result).to be_a(OpenStruct)
          expect(result.title).to eq('Rambo')
        end
      end
    end
  end
end
