# frozen_string_literal: true

module Api
  module V0
    class RegistrationController < ApplicationController
      def create
        client = Clients::SignUp.call(client_params)

        if client&.errors&.messages&.empty?
          response.headers['Authorization'] = "Bearer #{client.token}"
          render status: 200
        else
          render json: client.errors.messages.to_json, status: 400
        end
      end

      private

      def client_params
        params.require(:client)
              .permit(
                :login, :email,
                :password, :password_confirmation
              )
              .to_hash
              .transform_keys(&:to_sym)
      end
    end
  end
end
