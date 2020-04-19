require 'rails_helper'
require 'json'

describe "A post request to /api/v1/sessions" do
  it "A user can log in" do
    User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    params = {email: "whatever@example.com", password: "password"}

    post '/api/v1/sessions', params: params.to_json

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json["email"]).to_not be_empty
    expect(json["authentication_token"]).to_not be_empty
  end

  it 'does not log in a user if they are not valid' do
    User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    params = {email: "whatever@example.com", password: "ilovepuppies"}

    post '/api/v1/sessions', params: params.to_json

    expect(response.response_code).to eq 401

    json = JSON.parse(response.body)

    expect(response.body).to eq("{\"errors\":\"unauthorized\"}")
  end
end
