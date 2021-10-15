require 'rails_helper'

RSpec.describe MatchesController do
  let!(:user) { create :user }
  let!(:team) { create :team, user: user }
  let!(:match) { create :match, team: team }
  before do
    expect(controller).to receive(:authenticate_request).and_return true
    allow(controller).to receive(:current_user).and_return user
  end
  describe 'GET show' do
    it 'return match' do
      get :show, params: { uuid: match.uuid }
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ name: match.name, description: match.description, date: match.date.to_s }.to_json)
    end
    it 'return not found without uuid' do
      get :show, params: { uuid: '' }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to eq({ error_message: 'match not found' }.to_json)
    end
  end

  describe 'Get index' do
    it 'return matches' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(
        [{ name: match.name, description: match.description, date: match.date, uuid: match.uuid }].to_json
      )
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      it 'should update match' do
        get :update, params: { name: 'test', description: 'de', uuid: match.uuid }
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ success_message: 'match has been updated successfully' }.to_json)
      end
    end
    context 'with invalid params' do
      it 'fail and return error message' do
        get :update, params: { name: '', description: 'desc', uuid: match.uuid }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq({ error_message: 'match could not be updated' }.to_json)
      end
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'should create match' do
        get :create, params: { name: 'test', description: 'de', date: 2.days.from_now.to_date }
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ success_message: 'match has been created successfully' }.to_json)
      end
    end
    context 'with invalid params' do
      it 'fail and return error message' do
        get :create, params: { name: '', description: 'desc' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq({ error_message: 'match creation has failes' }.to_json)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'should delete match' do
      get :destroy, params: { uuid: match.uuid }
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ success_message: 'match got deleted successfully' }.to_json)
    end
  end
end
