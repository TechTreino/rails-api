# frozen_string_literal: true

FactoryGirl.define do
  factory :client do
    name { Faker::Company.name }
    address 'MyString'
    cnpj 'MyString'
    email { Faker::Internet.email }
  end
end
