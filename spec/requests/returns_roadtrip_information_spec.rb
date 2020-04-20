require 'rails_helper'

describe "POST request to /api/v1/road_trip" do
  it "returns all information needed for a roadtrip" do
    user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    params = {origin: "Denver,CO", destination: "Pueblo,CO", api_key: "#{user.authentication_token}"}

    post '/api/v1/road_trip', params: params.to_json

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json["data"].length).to eq(3)
    expect(json["data"]["attributes"]["origin"]).to_not be_empty
    expect(json["data"]["attributes"]["destination"]).to_not be_empty
    expect(json["data"]["attributes"]["travel_time"]).to_not be_empty
    expect(json["data"]["attributes"]["arrival_temp"]).to_not be_empty
    expect(json["data"]["attributes"]["arrival_weather_discription"]).to_not be_empty
  end
end
