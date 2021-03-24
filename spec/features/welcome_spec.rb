require 'rails_helper'

RSpec.describe 'welcome page' do
  it 'displays a welcome message' do
    visit root_path

    expect(page).to have_content('Welcome')
    expect(page).to have_selector('#blurb')
  end

  it 'displays login and register links' do
    visit root_path

    expect(page).to have_link('Register')
    expect(page).to have_link('Log In')
  end
end
