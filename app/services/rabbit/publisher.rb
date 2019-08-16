# frozen_string_literal: true

module Rabbit
  class Publisher < Base
    def call
      publish
    end

    private

    attr_reader :exchange, :message

    def initialize(exchange:, message:)
      @exchange = exchange
      @message  = message
    end

    def channel
      @channel ||= connection.create_channel
    end

    def connection
      @connection ||= Connection.instance.active
    end

    def publish
      x = channel.fanout(exchange)
      x.publish(message.to_json)
    end
  end
end
