require 'rails_helper'
require 'ostruct'

RSpec.describe 'the movieDB api service' do
  describe 'class methods' do
    describe '::details_for' do
      it 'returns ostruct with title, vote average, runtime' do
        VCR.use_cassette('rambo_movie_details') do
          result = TMDBService.details_for(7555)

          expect(result).to be_a(OpenStruct)
          expect(result.api_id).to eq(7555)
          expect(result.title).to eq('Rambo')
          expect(result.vote_average).to eq(6.6)
          expect(result.runtime).to eq(92)
          expect(result.genres).to eq(['Action', 'Thriller'])
          expect(result.summary).to include('When governments fail to act on behalf of captive missionaries, ex-Green Beret John James Rambo')
        end
      end
    end

    describe '::reviews for' do
      it "returns reviews array of ostructs" do
        VCR.use_cassette('rambo_7555_reviews') do
          result = TMDBService.reviews_for(7555)

          expect(result.length).to eq(2)
          expect(result.class).to eq(Array)
          expect(result[0][:author]).to eq("JPV852")
        end
      end
    end

    describe '::cast_for' do
      it 'returns array of ostructs, each with actor and character names' do
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
        end
      end

      it 'returns empty array (and does not hit the endpoint) if limit is <= 0' do
        expect(TMDBService.cast_for(7555, 0)).to eq([])
        expect(TMDBService.cast_for(7555, -1)).to eq([])
      end
    end
    describe '::trending_weekly' do
      it 'returns an array of 40 trending movie ostructs' do
        VCR.use_cassette('trending_weekly') do
          result = TMDBService.movies_trending

          expect(result).to be_an(Array)
          expect(result.all? do |elem|
            elem.class == OpenStruct
          end
          ).to eq(true)
          expect(result.length).to eq(40)
          expect(result.first.id).to eq(791373)
          expect(result.last.id).to eq(299536)
        end
      end
    end

  end
end
