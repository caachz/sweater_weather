class AntipodeFacade
  attr_reader :id

  def initialize(origin)
    @origin = origin
    @geocode = GeocodingService.new
    @id = "null"
  end

  def start_location
    info = @geocode.geocode_conn(@origin)
    Location.new(@geocode.location_info(info))
  end

  def antipode_location
    result = AmypodeService.new(start_location.lat, start_location.lng)
    latlng = result.lat.to_s + ', ' + result.lng.to_s
    info = @geocode.reverse_conn(latlng)
    Location.new(@geocode.location_info(info))
  end

  def forecast
    weather = WeatherService.new(antipode_location.lat, antipode_location.lng)
    result = Forecast.new(weather.get_forecast)
    result.overview
  end

  def search_location
    start_location.name
  end

  def location_name
    antipode_location.name
  end
end
