require 'rails_helper'

describe "GET request to /api/v1/antipode?location=<start_location_city_name>" do
  it "returns the weather name and temp of the antipode of a location" do

    get "/api/v1/antipode?location=hongkong"

    expect(response).to be_successful

    json = JSON.parse(response.body)
    require "pry"; binding.pry
    expect(json["data"].length).to eq(3)
    expect(json["data"]["attributes"]["location_name"]).to_not be_empty
    expect(json["data"]["attributes"]["forecast"]["summary"]).to_not be_empty
    expect(json["data"]["attributes"]["forecast"]["current_temperature"]).to_not be_empty
    expect(json["data"]["attributes"]["search_location"]).to_not be_empty
  end
end
