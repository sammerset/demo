require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_uniqueness_of(:title) }
end
