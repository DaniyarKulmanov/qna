# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :test

  validates :title, :body, presence: true
end
