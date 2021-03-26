require 'rails_helper'

RSpec.describe 'the movieDB api service' do
  describe 'class methods' do
    it '::get_data' do
      raw = TMDBService.get_data("https://api.themoviedb.org/3/movie/top_rated?api_key=7977257dcd366127c720211a9f03229b&page=1")
      expect(raw.length).to eq(4)
      expect(raw.class).to eq(Hash)
    end
    it '::top_forty' do
      tops = TMDBService.top_forty

      expect(tops.length).to eq(2)
      expect(tops.class).to eq(Array)
    end
  end
end
