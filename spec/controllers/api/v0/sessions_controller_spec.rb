# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V0::SessionsController, type: :controller do
  describe '#create' do
    let(:client) { create(:client) }
    before { post :create, params: params }

    context 'client sign_up success' do
      let(:params) do
        {
          client: {
            login: client.login,
            password: client.password
          }
        }
      end

      it { expect(response.headers['Authorization']).to include('Bearer') }

      it { expect(response).to have_http_status(200) }
    end

    context 'client sign_up fail' do
      let(:params) do
        {
          client: {
            login: client.login,
            password: 'not_valid_password'
          }
        }
      end

      it { expect(response).to have_http_status(401) }
    end
  end
end
