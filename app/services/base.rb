# frozen_string_literal: true

class Base
  class << self
    def call(*options)
      new(*options).call
    end
  end
end
