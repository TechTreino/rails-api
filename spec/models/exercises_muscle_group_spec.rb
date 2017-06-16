# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExercisesMuscleGroup, type: :model do
  it { should belong_to(:exercise) }
  it { should belong_to(:muscle_group) }
end
