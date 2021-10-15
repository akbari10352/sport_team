require 'rails_helper'

RSpec.describe ManageTeam do

  let!(:user) { create :user }
  let!(:team) { create :team, user: user }
  describe '#show' do
    it 'should return team' do
      result = described_class.new(user)
      expect(result.show).to eq({ body: { name: team.name, description: team.description }, status: :ok})
    end
  end
  describe '#edit' do
    context 'with valid params' do
      let(:params) { { name: 'test', descripiton: 'desc' } }
      it 'should update the team' do
        result = described_class.new(user)
        expect(result.edit(params)).to eq({body: { success_message: 'team updated succssfully' }, status: :ok})
      end
    end
    context 'with invalid params' do
      let(:params) { { name: '', description: 'desc' } }
      it 'should not update the team and return error message' do
        result = described_class.new(user)
        expect(result.edit(params)).to eq({ body: { error_message: 'team update has failed' }, status: :unprocessable_entity })
      end
    end
  end
end
