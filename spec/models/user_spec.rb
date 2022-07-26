# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should have_many(:questions) }
  it { should have_many(:questions).dependent(:destroy) }

  it { should have_many(:answers) }
  it { should have_many(:answers).dependent(:destroy) }
end
