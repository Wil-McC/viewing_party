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
end
