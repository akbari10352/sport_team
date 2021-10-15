require 'rails_helper'

RSpec.describe AuthenticationController do
  let!(:user) { create :user }

  describe 'POST authenticate' do
    it 'return token' do
      get :authenticate, params: { email: user.email, password: user.password }

      expect(response).to have_http_status(:ok)
      expect(response.body['token']).to be_present
    end

    it 'return error' do
      get :authenticate, params: { email: user.email, password: '' }

      expect(response).to have_http_status(:unauthorized)
      expect(response.body['token']).not_to be_present
    end
  end

end
