require 'rails_helper'

describe "A post request to /api/v1/users" do
  it "creates a new user" do
    expect(User.all.length).to eq(0)

    post '/api/v1/users', :params => {email: "whatever@example.com",
                                      password: "password",
                                      password_confirmation: "password"}

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(User.all.length).to eq(1)
  end

  it "doesn't create a new user" do
    expect(User.all.length).to eq(0)

    post '/api/v1/users', :params => {email: "whatever@example.com",
                                      password: "password",
                                      password_confirmation: "passrrword"}

    expect(response.response_code).to eq 401

    expect(User.all.length).to eq(0)
  end
end
