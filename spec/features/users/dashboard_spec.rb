require 'rails_helper'

RSpec.describe 'User dashboard' do
  describe 'as an authenticated user' do

  end

  describe 'as a non-authenticated user' do
    it 'redirects to homepage with a flash message' do
      visit dashboard_path

      expect(current_path).to eq root_path
      expect(page).to have_content('You must be logged in to access this section')
    end
  end
end
