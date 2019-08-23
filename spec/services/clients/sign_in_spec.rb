# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Clients::SignIn do
  subject(:invoke) { described_class.call(params) }
  let!(:client) { create(:client) }

  describe '#call' do
    context 'return valid token with client id' do
      let(:params) { { login: client.login, password: client.password } }
      let(:hash) { JsonWebToken.decode(invoke.token) }

      it { expect(hash[:client_id]).to eq(client.id.to_s) }
      it { expect(hash).to have_key(:client_id) }
    end

    context 'with invalid password' do
      let(:params) { { login: client.login, password: 'test' } }

      it 'token is nil' do
        expect(invoke.token).to be_nil
      end

      it 'errors present' do
        expect(invoke.errors.any?).to eql(true)
      end
    end

    context 'with invalid login' do
      let(:params) { { login: 'login', password: client.password } }

      it 'client not found' do
        expect(invoke).to be_nil
      end
    end
  end
end
