require 'rails_helper'

RSpec.describe Manage do

  let!(:user) { create :user }
  describe '#initialize' do
    it 'should return user' do
      result = described_class.new(user)
      expect(result.user).to eq user
    end
  end
  describe '#response' do
    it 'should return body and status as hash' do
      result = described_class.new(user)
      expect(result.response({ message: 'yes' }, :ok)).to eq({body: { message: 'yes' }, status: :ok})
    end
  end
end
