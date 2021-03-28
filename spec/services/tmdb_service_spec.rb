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
          top40.keys.all? do |id|
            id.class == Integer
          end
        ).to eq(true)
        expect(
          top40.values.all? do |data|
            data.class == Array
          end
        ).to eq(true)
        expect(top40.keys.last).to eq(476292)
      end
    end
    it "return search result(s)" do
      VCR.use_cassette('rambo_search') do
        rambos = TMDBService.movie_search('rambo')
      end
    end
    it "cleans data for 1 page of results" do
      VCR.use_cassette('falafel_search') do
        data = TMDBService.movie_search('falafel')
        out = TMDBService.results(data)

        expect(out.length).to eq(5)
        expect(out.class).to eq(Hash)
      end
    end
    it "cleans data for 2 pages of results" do
      VCR.use_cassette('country_search') do
        data = TMDBService.movie_search('country')
        out = TMDBService.results(data)

        expect(out.length).to eq(40)
        expect(out.class).to eq(Hash)
      end
    end
    it "sad paths empty responses" do
      VCR.use_cassette('empty_search') do
        sad = TMDBService.movie_search('asdkjfhaskjsd')
        out = TMDBService.results(sad)

        expect(out).to eq('Your search returned no results')
      end
    end
  end
end
