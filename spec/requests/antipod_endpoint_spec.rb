require 'rails_helper'

describe "GET request to /api/v1/antipode?location=<start_location_city_name>" do
  it "returns the weather name and temp of the antipode of a location" do

    get "/api/v1/antipode?location=hongkong"

    expect(response).to be_successful

    json = JSON.parse(response.body)

    # expect(json["data"].length).to eq(3)
    # expect(json["data"]["attributes"]["today"].length).to eq(10)
    # expect(json["data"]["attributes"]["hourly"].length).to eq(8)
    # expect(json["data"]["attributes"]["daily"].length).to eq(5)
  end
end
