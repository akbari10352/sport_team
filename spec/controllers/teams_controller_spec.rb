require 'rails_helper'

RSpec.describe TeamsController do
  let!(:user) { create :user }
  let!(:team) { create :team, user: user }
  before do
    expect(controller).to receive(:authenticate_request).and_return true
    allow(controller).to receive(:current_user).and_return user
  end
  describe 'GET show' do
    it 'return team' do
      get :show
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ name: team.name, description: team.description }.to_json)
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      it 'should update team' do
        get :update, params: { name: 'test', description: 'desc' }
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ success_message: 'team updated succssfully' }.to_json)
      end
    end
    context 'with invalid params' do
      it 'fail and return error message' do
        get :update, params: { name: '', description: 'desc' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq({ error_message: 'team update has failed' }.to_json)
      end
    end
  end

end
