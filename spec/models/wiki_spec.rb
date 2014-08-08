require 'spec_helper'

describe Wiki do
  it { should have_many(:users).through(:collaborations) }
  it { should validate_uniqueness_of :title }
end