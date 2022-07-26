# frozen_string_literal: true

class Test < ApplicationRecord
  has_many :questions

  validates :title, :level, presence: true
  validates :level, numericality: { only_integer: true }
end
