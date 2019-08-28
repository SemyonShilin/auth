# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V0::SessionsController, type: :controller do
  let(:client) { create(:client) }

  describe '#create' do
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

  describe '#check' do
    let(:params) do
      {
        client: {
          login: client.login,
          password: client.password
        }
      }
    end

    before { post :create, params: params }
    before do
      @request.set_header('Authorization', token)
      get :check
    end

    context 'with valid token' do
      let(:token) { response.headers['Authorization'] }
      it { expect(response).to have_http_status(:ok) }
    end

    context 'with invalid token' do
      let(:token) { response.headers['Authorization'].chop }
      it { expect(response).to have_http_status(401) }
    end

    context 'with blank token' do
      let(:token) { '' }
      it { expect(response).to have_http_status(401) }
    end
  end
end
