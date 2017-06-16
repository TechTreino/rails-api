# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MuscleGroup, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:exercises).through(:exercises_muscle_groups) }
end
