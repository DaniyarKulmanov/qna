# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Test, type: :model do
  it { should have_many(:questions) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :level }
  it { should validate_numericality_of(:level) }
end
