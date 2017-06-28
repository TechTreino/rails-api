# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Workout, type: :model do
  subject { create(:workout) }

  it { should belong_to(:user) }
  it { should belong_to(:client) }
  it { should validate_presence_of(:name) }
end
