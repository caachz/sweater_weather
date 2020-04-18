require 'rails_helper'

describe "Retrieve weather for a city" do
  it "returns the weather based on city and state input" do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    json = JSON.parse(response.body)

    # expect(json["data"].count).to eq(3)
  end
end
