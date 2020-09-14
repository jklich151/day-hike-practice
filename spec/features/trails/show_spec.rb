require 'rails_helper'

RSpec.describe "Trail Show Page" do
  it "can see the name, address and total length of all trips this trail belongs to" do
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

    visit "/trails/#{trail_1.id}"

    expect(page).to have_content(trail_1.name)
    expect(page).to have_content(trail_1.address)
    expect(page).to have_content(trip_1.name)
    expect(page).to have_content(trip_1.total_distance)
    expect(page).to have_content(trip_2.name)
    expect(page).to have_content(trip_2.total_distance)
  end

  it "can see the total number of trips the trail is included in" do
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

    visit "/trails/#{trail_1.id}"

    expect(page).to have_content("Total Trips: 3")
  end
end
