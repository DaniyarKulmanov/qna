# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :answers

  validates :title, :body, presence: true
end
