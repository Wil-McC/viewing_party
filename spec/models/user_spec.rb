require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'relationships' do
    it { should have_many :friendships }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many :parties }
    it { should have_many :invitations }
    it { should have_many(:invited_to_parties).through(:invitations) }
  end

  describe 'class methods' do
    describe '::by_email' do
      it 'returns user object if there is a user with that email' do
        user = create(:user)

        expect(User.by_email(user.email)).to eq(user)
      end

      it 'returns ___ if there is no user with that email' do
        expect(User.by_email('foo@example.com')).to be_nil
      end
    end
  end

  describe 'instance methods' do
    describe '#viewing_parties_involving_me' do
      it 'shows hosted and invited-to parties together' do
        user = create(:user)
        party_1 = create(:party, user: user)
        party_2 = create(:party, user: user)
        party_3 = create(:party)
        party_4 = create(:party)
        invitation_1 = create(:invitee, party: party_3, user: user)
        invitation_2 = create(:invitee, party: party_4, user: user)

        expect(user.viewing_parties_involving_me).to eq([party_1, party_2, party_3, party_4])
      end

      it 'shows only parties I am hosting if not invited to any' do
        user = create(:user)
        party_1 = create(:party, user: user)
        party_2 = create(:party, user: user)

        expect(user.viewing_parties_involving_me).to eq([party_1, party_2])
      end

      it 'shows only invited-to parties if I am not hosting any' do
        user = create(:user)
        party_1 = create(:party)
        party_2 = create(:party)
        invitation_1 = create(:invitee, party: party_1, user: user)
        invitation_2 = create(:invitee, party: party_2, user: user)

        expect(user.viewing_parties_involving_me).to eq([party_1, party_2])
      end

      it 'returns empty array if I am not involved with any parties :(' do
        user = create(:user)
        expect(user.viewing_parties_involving_me).to eq([])
      end
    end
  end
end
