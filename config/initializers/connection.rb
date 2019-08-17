module Rabbit
  class Connection
    include Singleton

    attr_reader :config

    def initialize
      @config  = Rails.application.credentials.rabbitmq
    end

    def active
      @active ||= Bunny.new(config).tap(&:start)
    end

    def connected?
      active.connected?
    end
  end
end