class Api::V1::ForecastsController < ApplicationController
  def show
    geocoding_conn = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?address=#{params["location"]}&key=#{ENV['GOOGLE_API_KEY']}")

    geocoding_response = geocoding_conn.get

    geocoding_json = JSON.parse(geocoding_response.body, symbolize_names: true)

    lat = geocoding_json[:results][0][:geometry][:location][:lat]
    lng = geocoding_json[:results][0][:geometry][:location][:lng]

    weather_conn = Faraday.new(url: "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lng}&appid=#{ENV['OPEN_WEATHER_API_KEY']}")

    weather_response = weather_conn.get

    weather_json = JSON.parse(weather_response.body, symbolize_names: true)

    render :json => weather_json
  end
end
