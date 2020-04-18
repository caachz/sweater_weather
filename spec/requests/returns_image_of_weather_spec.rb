require 'rails_helper'

describe "GET request to /api/v1/backgrounds?location=denver,co" do
  it "returns an image of the location" do

    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json["data"].length).to eq(3)
    expect(json["data"]["attributes"]["url"]).to_not be_empty
  end
end
