# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exercise, type: :model do
  subject { create(:exercise) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should belong_to(:muscle_group) }
  it { should belong_to(:client) }
end
