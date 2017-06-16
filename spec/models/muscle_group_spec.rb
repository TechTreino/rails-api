# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MuscleGroup, type: :model do
  subject { create(:muscle_group) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
