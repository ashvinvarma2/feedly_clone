# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    sequence(:title) { |n| "Board #{n}" }
    sequence(:description) { |n| "This is the new boards" }
    user
  end
end
