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
    it { should have_many :invitees }
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
      it 'includes parties I am hosting' do
        user = create(:user)
        party_1 = create(:party, user: user)
        party_2 = create(:party, user: user)

        expect(user.viewing_parties_invovling_me).to eq([party_1, party_2])
      end

      xit 'includes parties I am invited to' do

      end

      xit 'shows hosted and invited-to parties together' do

      end

      it 'returns empty array if I am not involved with any parties :(' do
        user = create(:user)
        expect(user.viewing_parties_invovling_me).to eq([])
      end
    end
  end
end
