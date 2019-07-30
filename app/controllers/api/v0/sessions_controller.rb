# frozen_string_literal: true

module Api
  module V0
    class SessionsController < ApplicationController
      def create
        client = Clients::SignIn.call(client_params)

        if client&.errors&.empty?
          response.headers['Authorization'] = "Bearer #{client.token}"
          render status: 200
        else
          render status: 401
        end
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
