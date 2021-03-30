require 'rails_helper'

RSpec.describe 'User Dashboard Viewing Party Section' do
  describe 'as an authenticated user' do
    describe 'viewing parties section' do
      it 'shows header' do
        login_user
        visit dashboard_path

        within('#viewing-parties') do
          header_text = page.find('.dashboard-header').text
          expect(header_text).to have_content('Viewing Parties')
        end
      end

      it 'shows message if I am not hosting or invited to any parties' do
        login_user
        visit dashboard_path

        within('#viewing-party-list') do
          party_elements = page.all('.viewing-party-card')
          expect(party_elements.size).to eq(0)
          expect(page).to have_content('You currently have no viewing parties.')
        end
      end

      it 'shows partes I am hosting' do
        login_user
        party_1 = create(:party, user: @user)
        party_2 = create(:party, user: @user)
        visit dashboard_path

        within('#viewing-party-list') do
          party_elements = page.all('.viewing-party-card')
          expect(party_elements.size).to eq(2)
        end
      end

      it 'shows correct info for a hosting card' do
        login_user
        hosted_party = create(:party, user: @user)
        movie = hosted_party.movie
        invitee_1 = create(:user)
        invitee_2 = create(:user)
        hosted_party.invitees << Invitee.new(party_id: hosted_party.id, user_id: invitee_1.id)
        hosted_party.invitees << Invitee.new(party_id: hosted_party.id, user_id: invitee_2.id)
        visit dashboard_path

        within('#viewing-party-list') do
          expect(page.all('.viewing-party-card').size).to eq(1)
        end

        within('.viewing-party-card') do
          # Movie title, which is a link to it's show apge
          link = page.find(:css, "a[href='#{movie_path(movie)}']")
          expect(link.text).to eq(movie.name)

          # Date and time of event
          expect(page).to have_content(hosted_party.start_time.strftime('%B %e, %Y'))
          expect(page).to have_content(hosted_party.start_time.strftime('%l:%M %p').strip)

          # That I am the host
          expect(page).to have_content('Hosting')

          # List of friends invited
          expect(page).to have_content(invitee_1.email)
          expect(page).to have_content(invitee_2.email)
        end
      end

      it 'shows parties I am invited to' do
        login_user
        party_1 = create(:party)
        party_2 = create(:party)
        party_1.invitees << Invitee.new(user_id: @user.id)
        party_2.invitees << Invitee.new(user_id: @user.id)
        visit dashboard_path

        within('#viewing-party-list') do
          party_elements = page.all('.viewing-party-card')
          expect(party_elements.size).to eq(2)
        end
      end

      it 'shows correct info for an invitee card' do
        login_user
        party = create(:party)
        movie = party.movie
        invitee_1 = create(:user)
        invitee_2 = create(:user)
        party.invitees << Invitee.new(user_id: @user.id)
        party.invitees << Invitee.new(user_id: invitee_1.id)
        party.invitees << Invitee.new(user_id: invitee_2.id)
        visit dashboard_path

        within('#viewing-party-list') do
          expect(page.all('.viewing-party-card').size).to eq(1)
        end

        within('.viewing-party-card') do
          # Movie title, which is a link to it's show apge
          link = page.find(:css, "a[href='#{movie_path(movie)}']")
          expect(link.text).to eq(movie.name)

          # Date and time of event
          expect(page).to have_content(party.start_time.strftime('%B %e, %Y'))
          expect(page).to have_content(party.start_time.strftime('%l:%M %p').strip)

          # Who is hosting it
          expect(page).to have_content(party.user.email)

          # List of friends invited, with me in bold
          page.find(:css, 'b', text: @user.email)
          expect(page).to have_content(@user.email)
          expect(page).to have_content(invitee_1.email)
          expect(page).to have_content(invitee_2.email)
        end
      end

      it 'shows hosting and invited parties at the same time' do
        login_user
        party_1 = create(:party, user: @user)
        party_2 = create(:party)
        party_2.invitees << Invitee.new(user_id: @user.id)
        visit dashboard_path

        within('#viewing-party-list') do
          party_elements = page.all('.viewing-party-card')
          expect(party_elements.size).to eq(2)
        end
      end

      it 'shows message if nobody is invited to the viewing party' do
        login_user
        party = create(:party, user: @user)
        visit dashboard_path

        expect(page.all('.viewing-party-card').size).to eq(1)

        within('.viewing-party-card') do
          expect(page).to have_content('Nobody is invited to this viewing party')
        end
      end
    end
  end

  def login_user
    @user = create(:user)
    perform_login(@user)
  end
end
