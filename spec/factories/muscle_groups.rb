# frozen_string_literal: true

FactoryGirl.define do
  factory :muscle_group do
    name { Faker::Lorem.word }
  end
end
