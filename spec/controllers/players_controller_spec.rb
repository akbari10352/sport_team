require 'rails_helper'

RSpec.describe PlayersController do
  let!(:user) { create :user }
  let!(:team) { create :team, user: user }
  let!(:player) { create :player, team: team }
  before do
    expect(controller).to receive(:authenticate_request).and_return true
    allow(controller).to receive(:current_user).and_return user
  end
  describe 'GET show' do
    it 'return player' do
      get :show, params: { uuid: player.uuid }
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ name: player.name, details: player.details }.to_json)
    end
    it 'return not found without uuid' do
      get :show, params: { uuid: '' }
      expect(response).to have_http_status(:not_found)
      expect(response.body).to eq({ error_message: 'player not found' }.to_json)
    end
  end

  describe 'Get index' do
    it 'return players' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq([{ name: player.name, uuid: player.uuid, details: player.details }].to_json)
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      it 'should update player' do
        get :update, params: { name: 'test', details: 'de', uuid: player.uuid }
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ success_message: 'player has been updated successfully' }.to_json)
      end
    end
    context 'with invalid params' do
      it 'fail and return error message' do
        get :update, params: { name: '', details: 'desc', uuid: player.uuid }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq({ error_message: 'player could not be updated' }.to_json)
      end
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'should create player' do
        get :create, params: { name: 'test', details: 'de' }
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ success_message: 'player has been created successfully' }.to_json)
      end
    end
    context 'with invalid params' do
      it 'fail and return error message' do
        get :create, params: { name: '', details: 'desc' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq({ error_message: 'player creation has failes' }.to_json)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'should delete player' do
      get :destroy, params: { uuid: player.uuid }
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ success_message: 'player got deleted successfully' }.to_json)
    end
  end
end
