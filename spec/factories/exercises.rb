# frozen_string_literal: true

FactoryGirl.define do
  factory :exercise do
    name { Faker::Lorem.word }

    muscle_group
    client
  end
end
