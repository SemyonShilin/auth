# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) { build(:client) }

  describe 'validations' do
    it { expect(client).to be_valid }

    it 'is not valid without a password' do
      client.password = nil
      expect(client).not_to be_valid
    end
  end
end
