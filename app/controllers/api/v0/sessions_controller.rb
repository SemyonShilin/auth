# frozen_string_literal: true

module Api
  module V0
    class SessionsController < ApplicationController
      def create
        client = Clients::SignIn.call(client_params)

        if client&.errors&.empty?
          response.headers['Authorization'] = "Bearer #{client.token}"
          render status: :ok
        else
          render status: :unauthorized
        end
      end

      def check
        render status: Clients::Check.call(headers: request.headers) ? :ok : :unauthorized
      end

      private

      def client_params
        params.require(:client)
              .permit(
                :login, :email, :password
              )
              .to_hash
              .transform_keys(&:to_sym)
      end
    end
  end
end
