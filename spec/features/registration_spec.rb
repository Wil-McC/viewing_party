require 'rails_helper'

RSpec.describe 'registration form' do
  it 'clicking on registration link leads to registration page' do
    visit root_path

    click_on 'Register'

    expect(current_path).to eq(registration_path)
  end

  it 'submits and creates on submit' do
    visit registration_path

    fill_in 'user[email]', with: 'beeps@beep.org'
    fill_in 'user[password]', with: 'secretbeeps'
    fill_in 'user[password_confirmation]', with: 'secretbeeps'

    click_on 'Register'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome beeps@beep.org!")
  end

  it "downcases email on creation" do
    visit registration_path

    fill_in 'user[email]', with: 'beePs@BEep.Org'
    fill_in 'user[password]', with: 'secretbeeps'
    fill_in 'user[password_confirmation]', with: 'secretbeeps'

    click_on 'Register'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome beeps@beep.org!")
  end

  it "doesn't redirect and displays sad flash on incomplete form" do
    visit registration_path

    fill_in 'user[email]', with: 'beePs@BEep.Org'

    click_on 'Register'

    expect(current_path).to eq(registration_path)
    expect(page).to have_content('Invalid Information Entered')
  end

  it "doesn't redirect and displays sad flash on password mismatch" do
    visit registration_path

    fill_in 'user[email]', with: 'beePs@BEep.Org'
    fill_in 'user[password]', with: 'secretbeeps'
    fill_in 'user[password_confirmation]', with: 'knownbeeps'

    click_on 'Register'

    expect(current_path).to eq(registration_path)
    expect(page).to have_content('Invalid Information Entered')
  end
end
