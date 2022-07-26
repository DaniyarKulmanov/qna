# frozen_string_literal: true

class Test < ApplicationRecord
  validates :title, :level, presence: true
  validates :level, numericality: { only_integer: true }
end
