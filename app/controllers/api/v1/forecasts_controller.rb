class Api::V1::ForecastsController < ApplicationController
  def show
    geocode = GeocodingService.new(params["location"])
    weather = WeatherService.new(geocode.lat, geocode.lng)

    render :json => weather.parse_json
  end
end
