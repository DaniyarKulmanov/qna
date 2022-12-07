# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { 'MyQuestionTitle' }
    body { 'MyQuestionText' }
    association :author

    trait :invalid do
      title { nil }
    end
  end
end
