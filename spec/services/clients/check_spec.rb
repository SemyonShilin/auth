# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Clients::Check do
  subject(:invoke) { described_class.call(headers: headers) }
  let!(:client) { create(:client) }
  let(:headers) do
    Struct.new(:env).new('Authorization' => token)
  end
  let(:client_id) { client.id.to_s }

  describe '#call' do
    context 'returned id with valid token' do
      let(:token) { JsonWebToken.encode(client_id: client_id) }

      it { expect(invoke.id.to_s).to eq(client_id) }
    end

    context 'result with invalid token' do
      let(:token) { JsonWebToken.encode(client_id: client.id.to_s).chop }

      it { expect(invoke).to be_falsey }
    end
  end
end
