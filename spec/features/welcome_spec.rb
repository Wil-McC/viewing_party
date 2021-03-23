require 'rails_helper'

RSpec.describe 'welcome page' do
  it 'displays a welcome message' do
    visit root_path

    expect(page).to have_content('Welcome')
  end
  xit "displays login and register links" do

  end
end
