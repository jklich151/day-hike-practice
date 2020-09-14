require 'rails_helper'

RSpec.describe "Trip Show Page" do
  it "can see a list of trails on that trip" do
    visitor_1 = Visitor.create(name: "Jenny")
    trip_1 = Trip.create(name: "Sunny Trip")
    trip_2 = Trip.create(name: "Cloudy Trip")
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
    trip_1.trails << trail_1
    trip_1.trails << trail_2
    trip_2.trails << trail_3

    visit "/trips/#{trip_1.id}"

    expect(page).to have_content(trail_1.name)
    expect(page).to have_content(trail_1.length)
    expect(page).to have_content(trail_1.address)
    expect(page).to have_content(trail_2.name)
    expect(page).to have_content(trail_2.length)
    expect(page).to have_content(trail_2.address)
    expect(page).to_not have_content(trail_3.name)
    expect(page).to_not have_content(trail_3.length)
    expect(page).to_not have_content(trail_3.address)
  end

  it "can see the total distance of all trails" do
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

    visit "/trips/#{trip_1.id}"

    expect(page).to have_content("Total Distance:15")
  end

  it "can see average distance of all trails" do
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

    visit "/trips/#{trip_1.id}"

    expect(page).to have_content("Average Distance: 5")
  end

  it "can see a heading, name and length for longest trip" do
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

    visit "/trips/#{trip_1.id}"

    within "#longest-#{trip_1.id}" do
      expect(page).to have_content("Longest Trail on Trip")
      expect(page).to have_content(trail_3.name)
      expect(page).to have_content(trail_3.length)
    end
  end

  it "can see a heading, name and length for shortest trail" do
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

    visit "/trips/#{trip_1.id}"

    within "#shortest-#{trip_1.id}" do
      expect(page).to have_content("Shortest Trail on Trip")
      expect(page).to have_content(trail_2.name)
      expect(page).to have_content(trail_2.length)
    end
  end

  it "can click on the name of a trail and go to it's show page" do
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

    visit "/trips/#{trip_1.id}"

    click_link "Trail_2"

    expect(current_path).to eq("/trails/#{trail_2.id}")
    expect(page).to have_content("Trail_2")
    expect(page).to have_content(3)
    expect(page).to have_content("Golden")
  end

  it "can remove a trail from the trip" do
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

    visit "/trips/#{trip_1.id}"

    within "#trail-#{trail_1.id}" do
      click_link "Delete Trail"
    end

    expect(current_path).to eq("/trips/#{trip_1.id}")
    expect(page).to_not have_content(trail_1.name)
    expect(page).to have_content(trail_2.name)
    expect(page).to have_content(trail_3.name)
  end
end
