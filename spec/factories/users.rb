# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "ashvin@test.com" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { "123456789" }
    password_confirmation { "123456789" }
  end
end
