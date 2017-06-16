# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exercise, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:muscle_groups).through(:exercises_muscle_groups) }
end
