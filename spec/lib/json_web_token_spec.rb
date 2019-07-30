# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonWebToken do
  subject(:encode) { described_class.encode(payload) }
  subject(:decode) { described_class.decode(encode) }
  let(:payload) { { client_id: 1, exp: Time.current + 10.seconds } }

  describe '#encode' do
    context 'returned token' do
      it { expect(encode).to be_an_instance_of(String) }
    end
  end

  describe '#decode' do
    context 'returned hash' do
      it { expect(decode).to have_key(:client_id) }
      it { expect(decode).to eq(payload.transform_keys!(&:to_s)) }
    end

    context 'invalid token' do
      let(:invalid_token) { encode + 'invalid' }
      it { expect(described_class.decode(invalid_token)).to be_nil }
    end
  end
end
