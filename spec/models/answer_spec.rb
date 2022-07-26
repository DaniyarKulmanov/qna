require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }

  it { should validate_presence_of :body }
  it do
    should validate_inclusion_of(:correct).
      in_array([true, false])
  end
end
