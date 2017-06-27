# frozen_string_literal: true

FactoryGirl.define do
  factory :user_role do
    user
    role
  end
end
