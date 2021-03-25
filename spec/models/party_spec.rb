require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :movie_id }
    it { should validate_presence_of :start_time }
  end
  describe 'relationships' do
    it { should belong_to :user}
    it { should belong_to :movie}
    it { should have_many :invitees }
  end
end
