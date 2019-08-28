# frozen_string_literal: tre

module Clients
  class SignIn < Base
    def call
      put_token if client && authenticate
      client
    end

    private

    attr_reader :login, :password

    def initialize(login:, password:, **_opts)
      @login = login
      @password = password
    end

    def client
      @client ||= Client.find_by(login: login)
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end

    def authenticate
      return client if client&.authenticate(password)

      client.errors.add(:client_authentication, 'invalid credentials')
      nil
    end

    def generate_token
      JsonWebToken.encode(client_id: client.id.to_s)
    end

    def put_token
      client.token = generate_token
    end
  end
end
