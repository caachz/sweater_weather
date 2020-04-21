class RoadtripFacade
  attr_reader :origin, :destination, :id

  def initialize(origin, destination)
    @id = "null"
    @origin = origin
    @destination = destination
  end

  def distance
    DirectionsService.new(@origin, @destination)
  end

  def travel_time
    distance.distance_text
  end

  def arrival_forecast
    geocode = GeocodingService.new
    info = geocode.geocode_conn(@destination)
    location = Location.new(geocode.location_info(info))

    weather = WeatherService.new(location.lat, location.lng)

    forecast = Forecast.new(weather.get_forecast)
    forecast.arrival_forecast(distance.distance_value)
  end
end
