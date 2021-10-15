require 'rails_helper'

RSpec.describe ManagePlayer do
  let!(:user) { create :user }
  let!(:team) { create :team, user: user }
  let(:not_found) { { body: { error_message: 'player not found' }, status: :not_found } }
  describe '#show' do
    context 'with invalid uuid' do
      it 'should return not found' do
        result = described_class.new(user)
        expect(result.show('')).to eq(not_found)
      end
    end
    context 'with valid uuid' do
      let!(:player) { create :player, team: team }
      it 'should return team' do
        result = described_class.new(user)
        expect(result.show(player.uuid)).to eq({ body: { name: player.name, details: player.details }, status: :ok })
      end
    end
  end

  describe '#show' do
    context 'with valid uuid' do
      let!(:player) { create :player, team: team }
      it 'should return team' do
        result = described_class.new(user)
        expect(result.players).to eq(
          { body: [{ name: player.name, details: player.details, uuid: player.uuid }.stringify_keys], status: :ok }
        )
      end
    end
  end

  describe '#add' do
    let!(:player) { create :player, team: team }
    context 'with valid params' do
      let(:params) { { name: 'test', details: 'details' } }
      it 'should create the player' do
        result = described_class.new(user)
        expect(result.add(params)).to eq(
          { body: { success_message: 'player has been created successfully' }, status: :ok }
        )
      end
    end
    context 'with invalid params' do
      let(:params) { { name: '', details: 'details' } }
      it 'should not create the player and return error message' do
        result = described_class.new(user)
        expect(result.add(params)).to eq(
          { body: { error_message: 'player creation has failes' }, status: :unprocessable_entity }
        )
      end
    end
  end

  describe '#edit' do
    let!(:player) { create :player, team: team }
    context 'with invalid uuid' do
      let(:params) { { name: 'test', details: 'details', uuid: '' } }
      it 'should return not found' do
        result = described_class.new(user)
        expect(result.edit(params)).to eq(not_found)
      end
    end
    context 'with valid params' do
      let(:params) { { name: 'test', details: 'details', uuid: player.uuid } }
      it 'should update the player' do
        result = described_class.new(user)
        expect(result.edit(params)).to eq(
          { body: { success_message: 'player has been updated successfully' }, status: :ok }
        )
      end
    end
    context 'with invalid params' do
      let(:params) { { name: '', details: 'details', uuid: player.uuid } }
      it 'should not update the player and return error message' do
        result = described_class.new(user)
        expect(result.edit(params)).to eq(
          { body: { error_message: 'player could not be updated' }, status: :unprocessable_entity }
        )
      end
    end
  end

  describe '#delete' do
    context 'with invalid uuid' do
      it 'should return not found' do
        result = described_class.new(user)
        expect(result.delete('')).to eq(not_found)
      end
    end
    context 'with valid uuid' do
      let!(:player) { create :player, team: team }
      it 'should return team' do
        result = described_class.new(user)
        expect(result.delete(player.uuid)).to eq({ body: { success_message: 'player got deleted successfully' }, status: :ok })
      end
    end
  end
end
