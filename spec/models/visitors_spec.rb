require 'rails_helper'

describe Visitor, type: :model do
  describe "relationships" do
    it { should have_many :trips }
  end
  describe "validations" do
    it { should validate_presence_of :name }
  end
end
