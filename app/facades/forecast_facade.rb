class ForecastFacade
  attr_reader :id

  def initialize(origin)
    @origin = origin
    @geocode = GeocodingService.new
    @id = "null"
  end

  def forecast
    result = @geocode.geocode_conn(@origin)
    location = Location.new(@geocode.location_info(result))
    weather = WeatherService.new(location.lat, location.lng).get_forecast
    Forecast.new(weather)
  end

  def today
    forecast.today
  end

  def hourly
    forecast.hourly
  end

  def daily
    forecast.daily
  end
end
