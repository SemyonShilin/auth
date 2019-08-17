# frozen_string_literal: true

module Rabbit
  class Publisher < Base
    def call
      logger.info("Publishing message start: #{message}")
      publish
      logger.info("Publishing message end: #{message}")
    end

    private

    attr_reader :exchange, :message, :logger

    def initialize(exchange:, message:, logger: Rails.logger)
      @exchange = exchange
      @message  = message
      @logger   = logger
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
