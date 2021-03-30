require 'rails_helper'

RSpec.describe 'Movie details page' do
  describe 'as an authenticated user' do

  end

  describe 'as a non-authenticated user' do
    it 'redirects to homepage with a flash message' do
      visit movie_path(id: 1)

      expect(current_path).to eq root_path
      expect(page).to have_content('You must be logged in to access this section')
    end
  end

  def login_user
    @user = create(:user)
    perform_login(@user)
  end
end
