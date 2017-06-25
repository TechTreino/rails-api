# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  subject { create(:client) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:slug) }
end
