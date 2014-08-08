require 'spec_helper'

describe Collaboration do
  it { should validate_uniqueness_of(:user_id).scoped_to(:wiki_id)}
end