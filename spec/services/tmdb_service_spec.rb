require 'rails_helper'

RSpec.describe 'the movieDB api service' do
  describe 'class methods' do
    it '::top_forty' do
      tops = TMDBService.top_forty

      expect(tops.length).to eq(2)
      expect(tops.class).to eq(Array)
    end
    it '::movies' do
      top40 = TMDBService.movies

      expect(top40.length).to eq(40)
      expect(top40.class).to eq(Hash)
      expect(top40.keys.last).to eq('Spider-Man: Into the Spider-Verse')
    end
  end
end
