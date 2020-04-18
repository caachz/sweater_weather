require 'rails_helper'

describe "Retrieve weather for a city" do
  it "returns the weather based on city and state input" do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    json = JSON.parse(response.body)
    
    #now: temp now, high temp, low temp, description, feels like, humidity, visibility, uv index, sunrise, sunset
    today_temp_now = json["current"]["temp"]
    today_high_temp = json["daily"][0]["temp"]["max"]
    today_low_temp = json["daily"][0]["temp"]["min"]
    today_description = json["current"]["weather"][0]["description"]
    today_feels_like = json["current"]["feels_like"]
    today_humidity = json["current"]["humidity"]
    today_visibilty = json["current"]["visibility"]
    today_uv_index = json["current"]["uvi"]
    today_sunrise = json["current"]["sunrise"]
    today_sunset = json["current"]["sunset"]

    #8 hours of weather: time, description, temp
    hourly = json["hourly"][0..7]
    #5 days of weather: description, mm of rain, high temp, low temp
    daily = json["daily"][0..4]
    # expect(json["data"].count).to eq(3)
  end
end
