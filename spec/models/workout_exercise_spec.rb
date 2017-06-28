# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkoutExercise, type: :model do
  subject { create(:workout_exercise) }

  it { should belong_to(:workout) }
  it { should belong_to(:exercise) }
end
