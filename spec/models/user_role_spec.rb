# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRole, type: :model do
  subject { create(:user_role) }

  before { UserRole.destroy_all }
  it { should belong_to(:user) }
  it { should belong_to(:role) }
end
