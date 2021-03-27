require 'rails_helper'

RSpec.describe 'the movieDB api service' do
  describe 'class methods' do
    it '::top_forty' do
      # response = File.read('spec/fixtures/top_40_page_1.json')

      # stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MDB_KEY']}&page=1").
         # with(
           # headers: {
             # "api_key": ENV['MDB_KEY']
           # }).
         # to_return(status: 200, body: response, headers: {})

      VCR.use_cassette('top_forty') do
        tops = TMDBService.top_forty

        expect(tops.length).to eq(2)
        expect(tops.class).to eq(Array)
      end
    end
    it '::movies' do
      VCR.use_cassette('movies') do
        top40 = TMDBService.movies

        expect(top40.length).to eq(40)
        expect(top40.class).to eq(Hash)
        expect(
          top40.keys.all? do |title|
            title.class == String
          end
        ).to eq(true)
        expect(
          top40.values.all? do |rating|
            rating.class == Float
          end
        ).to eq(true)
        expect(top40.keys.last).to eq("Maquia: When the Promised Flower Blooms")
      end
    end
    it "return search result(s)" do
      VCR.use_cassette('rambo_search') do
        rambos = TMDBService.movie_search('rambo')
      end
    end
    # sad = TMDBService.movie_search('asdkjfhaskjsd')
  end
end
