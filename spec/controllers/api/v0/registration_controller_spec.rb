# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V0::RegistrationController, type: :controller do
  describe '#create' do
    before do
      post :create, params: params
    end

    context 'client sign_up success' do
      let(:params) do
        {
          client: {
            login: 'client',
            email: 'client@mail.ru',
            password: 'password',
            password_confirmation: 'password'
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
            login: 'client',
            email: 'client@mail.ru',
            password: 'password',
            password_confirmation: 'password1'
          }
        }
      end

      it { expect(JSON.parse(response.body)).to have_key('password_confirmation') }

      it { expect(response).to have_http_status(400) }
    end
  end
end
