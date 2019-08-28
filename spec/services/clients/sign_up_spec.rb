# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Clients::SignUp do
  subject(:invoke) { described_class.call(params) }

  describe '#call' do
    context 'with valid params' do
      let(:params) do
        {
          login: 'login',
          email: 'login@mail.com',
          password: 'password',
          password_confirmation: 'password'
        }
      end
      let(:hash) { JsonWebToken.decode(invoke.token) }

      it { expect(hash[:client_id]).to eq(Client.last.id.to_s) }
      it { expect(hash).to have_key(:client_id) }
    end

    context 'with invalid password confirmation' do
      let(:params) do
        {
          login: 'login',
          email: 'login@mail.com',
          password: 'password',
          password_confirmation: 'other_password'
        }
      end

      it 'have errors' do
        expect(invoke.errors.messages).to have_key(:password_confirmation)
      end
    end

    context 'with password less than 6 symbol' do
      let(:params) do
        {
          login: 'login',
          email: 'login@mail.com',
          password: 'pass',
          password_confirmation: 'pass'
        }
      end

      it 'have errors' do
        expect(invoke.errors.messages).to have_key(:password)
      end
    end
  end
end
