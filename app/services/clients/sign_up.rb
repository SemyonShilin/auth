# frozen_string_literal: tre

module Clients
  class SignUp < Base
    def call
      if form.persist
        SignIn.call(**params)
      else
        form
      end
    end

    private

    attr_reader :params

    def initialize(params)
      @params = params
    end

    def form
      @form ||= NewForm.new(build_resource, params)
    end

    def build_resource
      ::Client.new
    end
  end
end
