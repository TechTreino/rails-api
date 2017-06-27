# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { create(:role) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
