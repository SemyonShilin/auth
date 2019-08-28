# frozen_string_literal: tre

# clients documents
class Client
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  attr_accessor :token

  field :email, type: String
  field :login, type: String
  field :password_digest, type: String

  index({ email: 1 }, unique: true)
  index({ login: 1 }, unique: true)

  has_secure_password
end
