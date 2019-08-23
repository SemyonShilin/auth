# frozen_string_literal: tre

module Clients
  class Check < Base
    def call
      return body unless body

      token_is_alive? ? client : false
    end

    private

    attr_reader :token

    def initialize(headers:)
      @token = select_token(headers)
    end

    def client
      @client ||= Client.find(body[:client_id])
    rescue Mongoid::Errors::DocumentNotFound
      false
    end

    def body
      @body ||= JsonWebToken.decode(token)
    end

    def select_token(headers)
      headers.env['Authorization']&.split(' ')&.last
    end

    def token_is_alive?
      body[:exp] >= Time.now.to_i
    end
  end
end
