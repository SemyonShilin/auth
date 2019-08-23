# frozen_string_literal: true

module Clients
  class NewForm < BaseForm
    model :client

    property :login, type: ::Types::String
    property :email, type: ::Types::String
    property :password, type: ::Types::String
    property :password_confirmation, type: ::Types::String

    validation do
      configure do
        config.messages_file = Rails.root + 'config/locales/dry_validation.yml'
        option :record

        def unique?(attr_name, value)
          ::Client.where(attr_name => value).empty?
        end
      end

      required(:email).filled(unique?: :email)
      required(:login).filled(unique?: :login)

      required(:password).filled(min_size?: 6).confirmation
    end

    def for_queue
      {
        external_id: model.id.to_s,
        login: model.login,
        email: model.email
      }
    end
  end
end
