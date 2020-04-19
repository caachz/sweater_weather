require 'rails_helper'
require 'json'

describe "A post request to /api/v1/users" do
  it "creates a new user" do
    expect(User.all.length).to eq(0)

    params = {email: "whatever@example.com", password: "password", password_confirmation: "password"}

    post '/api/v1/users', params: params.to_json

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(User.all.length).to eq(1)
  end

  it "doesn't create a new user" do

    expect(User.all.length).to eq(0)

    params = {email: "whatever@example.com", password: "password", password_confirmation: "passrrword"}

    post '/api/v1/users', params: params.to_json

    expect(response.response_code).to eq 401

    expect(User.all.length).to eq(0)
    expect(response.body).to eq("{\"errors\":\"user cannot be created with these credentials\"}")
  end
end
