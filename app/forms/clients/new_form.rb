# frozen_string_literal: true

module Clients
  class NewForm < BaseForm
    model :client

    property :login, type: ::Types::String
    property :email, type: ::Types::String
    property :password, type: ::Types::String
    property :password_confirmation, type: ::Types::String

    validation do
      required(:email).filled
      required(:login).filled

      required(:password).filled(min_size?: 6).confirmation
    end

    def for_queue
      {
        id: model.id,
        login: model.login,
        email: model.email
      }
    end
  end
end
