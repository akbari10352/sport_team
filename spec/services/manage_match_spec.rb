require 'rails_helper'

RSpec.describe ManageMatch do
  let!(:user) { create :user }
  let!(:team) { create :team, user: user }
  let(:not_found) { { body: { error_message: 'match not found' }, status: :not_found } }
  describe '#show' do
    context 'with invalid uuid' do
      it 'should return not found' do
        result = described_class.new(user)
        expect(result.show('')).to eq(not_found)
      end
    end
    context 'with valid uuid' do
      let!(:match) { create :match, team: team }
      it 'should return team' do
        result = described_class.new(user)
        expect(result.show(match.uuid)).to eq(
          { body: { name: match.name, description: match.description, date: match.date }, status: :ok }
        )
      end
    end
  end

  describe '#matches' do
    context 'with valid uuid' do
      let!(:match) { create :match, team: team }
      it 'should return team' do
        result = described_class.new(user)
        expect(result.matches).to eq(
          { body: [
              {
                name: match.name,
                description: match.description,
                uuid: match.uuid,
                date: match.date
              }.stringify_keys
            ], status: :ok }
        )
      end
    end
  end

  describe '#add' do
    let!(:match) { create :match, team: team }
    context 'with valid params' do
      let(:params) { { name: 'test', description: 'description', date: 3.days.from_now.to_date } }
      it 'should create the match' do
        result = described_class.new(user)
        expect(result.add(params)).to eq(
          { body: { success_message: 'match has been created successfully' }, status: :ok }
        )
      end
    end
    context 'with invalid params' do
      let(:params) { { name: '', description: 'description', date: 3.days.from_now.to_date } }
      it 'should not create the match and return error message' do
        result = described_class.new(user)
        expect(result.add(params)).to eq(
          { body: { error_message: 'match creation has failes' }, status: :unprocessable_entity }
        )
      end
    end
  end

  describe '#edit' do
    let!(:match) { create :match, team: team }
    context 'with invalid uuid' do
      let(:params) { { name: 'test', description: 'description', uuid: '', date: 3.days.from_now.to_date } }
      it 'should return not found' do
        result = described_class.new(user)
        expect(result.edit(params)).to eq(not_found)
      end
    end
    context 'with valid params' do
      let(:params) do
        { name: 'test', description: 'description', uuid: match.uuid, date: 3.days.from_now.to_date }
      end
      it 'should update the match' do
        result = described_class.new(user)
        expect(result.edit(params)).to eq(
          { body: { success_message: 'match has been updated successfully' }, status: :ok }
        )
      end
    end
    context 'with invalid params' do
      let(:params) do
        { name: '', description: 'description', uuid: match.uuid, date: 3.days.from_now.to_date }
      end
      it 'should not update the match and return error message' do
        result = described_class.new(user)
        expect(result.edit(params)).to eq(
          { body: { error_message: 'match could not be updated' }, status: :unprocessable_entity }
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
      let!(:match) { create :match, team: team }
      it 'should return team' do
        result = described_class.new(user)
        expect(result.delete(match.uuid)).to eq(
          { body: { success_message: 'match got deleted successfully' }, status: :ok }
        )
      end
    end
  end
end
