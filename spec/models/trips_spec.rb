require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe "relationships" do
    it {should have_many :trail_trips}
    it {should have_many(:trails).through(:trail_trips)}
  end

  describe "instance methods" do
    it "#total_distance" do
      visitor_1 = Visitor.create(name: "Jenny")
      trip_1 = Trip.create(name: "Sunny Trip")
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
      trip_1.trails << trail_1
      trip_1.trails << trail_2
      trip_1.trails << trail_3

      expect(trip_1.total_distance).to eq(15)
    end

    it "#average_distance" do
      visitor_1 = Visitor.create(name: "Jenny")
      trip_1 = Trip.create(name: "Sunny Trip")
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
      trip_1.trails << trail_1
      trip_1.trails << trail_2
      trip_1.trails << trail_3

      expect(trip_1.average_distance).to eq(5)
    end

    it "#longest_trail" do
      visitor_1 = Visitor.create(name: "Jenny")
      trip_1 = Trip.create(name: "Sunny Trip")
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
      trip_1.trails << trail_1
      trip_1.trails << trail_2
      trip_1.trails << trail_3

      expect(trip_1.longest_trail).to eq(trail_3)
    end

    it "#shortest_trail" do
      visitor_1 = Visitor.create(name: "Jenny")
      trip_1 = Trip.create(name: "Sunny Trip")
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
      trip_1.trails << trail_1
      trip_1.trails << trail_2
      trip_1.trails << trail_3

      expect(trip_1.shortest_trail).to eq(trail_2)
    end
  end
end
