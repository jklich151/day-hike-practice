require 'rails_helper'

RSpec.describe "Trips Index Page" do
  it "can see a list of all trip names" do
    visitor_1 = Visitor.create(name: "Jenny")
    trip_1 = Trip.create(name: "Sunny Trip")
    trip_2 = Trip.create(name: "Cloudy Trip")
    trip_3 = Trip.create(name: "Foggy Trip")

    visitor_1.trips << trip_1
    visitor_1.trips << trip_2
    visitor_1.trips << trip_3

    visit "/trips"

    expect(page).to have_content(trip_1.name)
    expect(page).to have_content(trip_2.name)
    expect(page).to have_content(trip_3.name)
  end

  it "can click the name of the trip and be taken to that trips show page" do
    visitor_1 = Visitor.create(name: "Jenny")
    trip_1 = Trip.create(name: "Sunny Trip")
    trip_2 = Trip.create(name: "Cloudy Trip")
    trip_3 = Trip.create(name: "Foggy Trip")

    visitor_1.trips << trip_1
    visitor_1.trips << trip_2
    visitor_1.trips << trip_3

    visit "/trips"

    within "#index-#{trip_1.id}" do
      click_link "Sunny Trip"
    end

    expect(current_path).to eq("/trips/#{trip_1.id}")
    expect(page).to have_content(trip_1.name)
    expect(page).to_not have_content(trip_2.name)
  end
end
