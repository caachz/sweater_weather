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
    geocode = GeocodingService.new(@destination)
    geocode.geocode_conn
    lat = geocode.lat
    lng = geocode.lng

    weather = WeatherService.new(lat, lng).arrival_forecast(distance.distance_value)
  end
end
