require 'rails_helper'

RSpec.describe 'registration form' do
  it 'clicking on registration link leads to registration page' do
    visit root_path

    click_on 'Register'

    expect(current_path).to eq(new_user_path)
  end

  it 'submits and creates on submit' do
    visit new_user_path

    fill_in 'user[email]', with: 'beeps@beep.org'
    fill_in 'user[password]', with: 'secretbeeps'

    click_on 'Register'

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Welcome beeps@beep.org!")
  end
  it "downcases email on creation" do
    visit new_user_path

    fill_in 'user[email]', with: 'beePs@BEep.Org'
    fill_in 'user[password]', with: 'secretbeeps'

    click_on 'Register'

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Welcome beeps@beep.org!")
  end
  it "doesn't redirect and displays sad flash on incomplete form" do
    visit new_user_path

    fill_in 'user[email]', with: 'beePs@BEep.Org'

    click_on 'Register'

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content('Invalid Information Entered')
  end
end
