require 'rails_helper'

describe "POST request to /api/v1/road_trip" do
  it "returns all information needed for a roadtrip" do

    user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    params = {origin: "Denver,CO", destination: "Pueblo,CO", api_key: "#{user.authentication_token}"}

    post '/api/v1/road_trip', params: params

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json["data"].length).to eq(3)
    expect(json["data"]["attributes"]["origin"]).to_not be_empty
    expect(json["data"]["attributes"]["destination"]).to_not be_empty
    expect(json["data"]["attributes"]["travel_time"]).to_not be_empty
    expect(json["data"]["attributes"]["arrival_forecast"].length).to eq(2)
    expect(json["data"]["attributes"]["arrival_forecast"]["description"]).to_not be_empty
  end

  it 'returns a 401 error if api_key invalid' do
    User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    params = {origin: "Denver,CO", destination: "Pueblo,CO", api_key: "jgn983hy48thw9begh98h4539h4"}

    post '/api/v1/road_trip', params: params

    expect(response.response_code).to eq 401

    json = JSON.parse(response.body)

    expect(response.body).to eq("{\"errors\":\"unauthorized\"}")
  end
end
