# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { 'MyText' }
    correct { false }
    question

    trait :wrong do
      body { nil }
    end
  end
end
