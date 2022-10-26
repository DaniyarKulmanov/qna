# frozen_string_literal: true

FactoryBot.define do
  sequence :body do |n|
    "MyText#{n}"
  end

  factory :answer do
    body
    question
    association :author

    trait :wrong do
      body { nil }
    end
  end
end
