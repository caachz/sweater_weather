class ForecastFacade
  attr_reader :forecast

  def initialize(location)
    geocode = GeocodingService.new(location)
    geocode.geocode_conn
    weather = WeatherService.new(geocode.lat, geocode.lng)

    @forecast = weather.forecast
  end
end
