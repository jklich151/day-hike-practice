require 'rails_helper'

describe Trail, type: :model do
  describe 'validations' do
    it { should validate_presence_of :length }
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }

    it { should validate_numericality_of(:length).only_integer }
    it { should validate_numericality_of(:length).is_greater_than(0) }
  end
  describe "relationships" do
    it { should have_many :trail_trips}
    it {should have_many(:trips).through(:trail_trips)}
  end

  describe "instance methods" do
    it "#all_trips" do
      visitor_1 = Visitor.create(name: "Jenny")
      trip_1 = Trip.create(name: "Sunny Trip")
      trip_2 = Trip.create(name: "Cloudy Trip")
      trip_3 = Trip.create(name: "Foggy Trip")
      trail_1 = Trail.create(name: "Trail_1",
                            length: 5,
                            address: "Boulder")
      trail_2 = Trail.create(name: "Trail_2",
                            length: 3,
                            address: "Golden")
      trail_3 = Trail.create(name: "Trail_3",
                            length: 7,
                            address: "Nederland")

      visitor_1.trips << trip_1
      visitor_1.trips << trip_2
      visitor_1.trips << trip_3
      trip_1.trails << trail_1
      trip_1.trails << trail_2
      trip_2.trails << trail_1
      trip_2.trails << trail_3
      trip_3.trails << trail_1
      trip_3.trails << trail_3

      expect(trail_1.all_trips).to eq(3)
    end
  end
end
