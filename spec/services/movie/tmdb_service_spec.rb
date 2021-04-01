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
        tops = TMDBService.movies_top

        expect(tops.length).to eq(40)
        expect(tops.class).to eq(Array)
        expect(
          tops.all? do |elem|
            elem.class == OpenStruct
          end
        ).to eq(true)
      end
    end
    it "::string_cleaner" do
      expect(TMDBService.string_cleaner('lord of the rings')).to eq('lord+of+the+rings')
    end
    it "::search_call" do
      VCR.use_cassette('multi_search') do
        lotr = TMDBService.search_call('lord of the rings')

        expect(lotr.class).to eq(Array)
        expect(lotr.length).to eq(13)
        expect(lotr.all? do |elem|
            elem.class == Hash
          end
        ).to eq(true)
      end
    end
    it "::where_to_watch" do
      VCR.use_cassette('w2w') do
        wtw = TMDBService.where_to_watch(7555)

        expect(wtw.link).to eq('https://www.themoviedb.org/movie/7555-rambo/watch?locale=US')
      end
    end
  end
  describe '::movie_search' do
    it "return search result(s)" do
      VCR.use_cassette('rambo_search') do
        rambos = TMDBService.movie_search('rambo')

        expect(rambos.length).to eq(40)
        expect(rambos.class).to eq(Array)
        expect(rambos.all? do |elem|
            elem.class == OpenStruct
          end
        ).to eq(true)
      end
    end
  end
  describe '::results' do
    it "cleans data for 1 page of results" do
      VCR.use_cassette('falafel_search') do
        data = TMDBService.movie_search('falafel')

        expect(data.length).to eq(5)
        expect(data.class).to eq(Array)
        expect(data.all? do |elem|
            elem.class == OpenStruct
          end
        ).to eq(true)
      end
    end
    it "cleans data for 2 pages of results" do
      VCR.use_cassette('country_search') do
        out = TMDBService.movie_search('country')

        expect(out.length).to eq(40)
        expect(out.class).to eq(Array)
        expect(out.all? do |elem|
            elem.class == OpenStruct
          end
        ).to eq(true)
      end
    end
    it "returns results from a multi-word search" do
      VCR.use_cassette('multi_search') do
        out = TMDBService.movie_search('lord of the rings')

        expect(out.length).to eq(13)
        expect(out.class).to eq(Array)
      end
    end
  end

  describe 'extension - errors' do
    xit "handles error responses from api" do
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MDB_KEY']}&page=1")
      .to_return(status: 404, body: "", headers: {})

      expect(TMDBService.movies).to eq()

    end
  end
  describe 'sad paths - queries' do
    it "empty responses from gibberish query" do
      VCR.use_cassette('empty_search_test') do
        out = TMDBService.movie_search('asdkjfhaskjsd')

        expect(out).to eq([])
      end
    end
  end
end
