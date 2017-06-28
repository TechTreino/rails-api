# frozen_string_literal: true

FactoryGirl.define do
  factory :workout do
    name { Faker::Lorem.word }

    client
    user
  end
end
