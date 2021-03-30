require 'rails_helper'

RSpec.describe 'the movieDB api service' do
  describe 'class methods' do
    it '::top_forty' do
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
    it "::string_cleaner" do
      expect(TMDBService.string_cleaner('lord of the rings')).to eq('lord+of+the+rings')
    end
    it "::search_call" do
      VCR.use_cassette('multi_search') do
        expect(TMDBService.search_call('3/search/movie', 'lord of the rings').class).to eq(Faraday::Response)
      end
    end
  end
  describe '::movie_search' do
    it "return search result(s)" do
      VCR.use_cassette('rambo_search') do
        rambos = TMDBService.movie_search('rambo')
        expect(rambos.length).to eq(2)
        expect(rambos.class).to eq(Array)
        expect(rambos[0].length).to eq(20)
        expect(rambos[0].class).to eq(Array)
        expect(rambos[1].length).to eq(20)
        expect(rambos[1].class).to eq(Array)
      end
    end
  end
  describe '::results' do
    it "cleans data for 1 page of results" do
      VCR.use_cassette('falafel_search') do
        data = TMDBService.results('falafel')

        expect(data.length).to eq(5)
        expect(data.class).to eq(Hash)
      end
    end
    it "cleans data for 2 pages of results" do
      VCR.use_cassette('country_search') do
        out = TMDBService.results('country')

        expect(out.length).to eq(40)
        expect(out.class).to eq(Hash)
      end
    end
    it "returns results from a multi-word search" do
      VCR.use_cassette('multi_search') do
        out = TMDBService.results('lord of the rings')

        expect(out.length).to eq(13)
        expect(out.class).to eq(Hash)
      end
    end
  end

  describe 'sad paths - errors' do
    xit "handles error responses from api" do
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MDB_KEY']}&page=1")
      .to_return(status: 404, body: "", headers: {})

      expect(TMDBService.movies).to eq()

    end
  end
  describe 'sad paths - queries' do
    it "empty responses from query" do
      VCR.use_cassette('empty_search') do
        out = TMDBService.results('asdkjfhaskjsd')

        expect(out).to eq('Your search returned no results')
      end
    end
  end
end
