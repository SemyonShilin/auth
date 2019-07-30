# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    login { 'client' }
    email { 'client@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
