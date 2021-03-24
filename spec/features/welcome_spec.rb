require 'rails_helper'

RSpec.describe 'welcome page' do
  it 'displays a welcome message' do
    visit root_path

    expect(page).to have_content('Welcome')
    expect(page).to have_selector('#blurb')
  end

  it 'displays register links' do
    visit root_path

    expect(page).to have_link('Register')
    click_link('Register')
    expect(current_path).to eq(new_user_path)
  end

  it 'displays login link' do
    visit root_path

    expect(page).to have_link('Log In')
    click_link('Log In')
    expect(current_path).to eq(login_path)
  end
end
