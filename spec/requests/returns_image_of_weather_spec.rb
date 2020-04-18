require 'rails_helper'

describe "Returns the image related to the current weather" do
  it "returns the correct image" do

    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json["data"].length).to eq(3)
    expect(json["data"]["attributes"]["url"]).to_not be_empty
  end
end
