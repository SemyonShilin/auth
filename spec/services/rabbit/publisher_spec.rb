# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rabbit::Publisher do
  subject(:invoke) { described_class.call(exchange: exchange, message: message) }
  let(:exchange) { 'client.test' }
  let(:message)  { { client: { id: client.id.to_s, email: client.email, login: client.login } } }
  let(:client) { create(:client) }
  let(:conn) { BunnyMock.new.start }

  before do
    allow(Rabbit::Connection.instance).to receive(:active).and_return(conn)
    BunnyMock.use_bunny_queue_pop_api = true
  end

  after { conn.close }

  describe '#call' do
    context 'should create exchanges' do
      before { invoke }
      it { expect(conn.exchange_exists?(exchange)).to be_truthy }
    end

    context 'put message to exchange' do
      it 'and queue should have one message' do
        channel = conn.create_channel
        channel.fanout(exchange)
        queue = channel.queue('consumer.test')
        queue.bind(exchange)

        invoke

        expect(queue.message_count).to eq(1)
      end

      it 'should have message with client' do
        channel = conn.create_channel
        channel.fanout(exchange)
        queue = channel.queue('consumer.test')
        queue.bind(exchange)

        invoke

        payload = queue.pop.last
        payload_message = JSON.parse(payload)

        expect(payload_message['client']).to have_key('id')
        expect(payload_message['client']).to have_key('email')
        expect(payload_message['client']).to have_key('login')
      end
    end
  end
end
