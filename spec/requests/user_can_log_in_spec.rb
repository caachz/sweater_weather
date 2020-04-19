require 'rails_helper'
require 'json'

describe "A post request to /api/v1/sessions" do
  it "A user can log in" do
    User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    params = {email: "whatever@example.com", password: "password"}

    post '/api/v1/sessions', params: params.to_json

    expect(response).to be_successful

    json = JSON.parse(response.body)

  end

  it 'does not log in a user if they are not valid' do

  end
end
