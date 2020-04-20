class AntipodeFacade
  attr_reader :antipode_name, :antipode_weather

  def initialize(origin)
    @origin_coodinates = geocode_origin(origin)
    @antipode_coodinates = find_antipode(@origin_coodinates.lat, @origin_coodinates.lng)
    @antipode_weather = current_weather(@antipode_coodinates.antipode_lat, @antipode_coodinates.antipode_lng)
    @antipode_name = reverse_geocode("#{@antipode_coodinates.antipode_lat}, #{@antipode_coodinates.antipode_lng}")
  end

  def geocode_origin(origin)
    result = GeocodingService.new(origin)
    result.geocode_conn
    result
  end

  def find_antipode(lat, lng)
    antipode_city = AmypodeService.new(lat, lng)
  end

  def current_weather(lat, lng)
    antipode_weather = WeatherService.new(lat, lng)
  end

  def reverse_geocode(location)
    result = GeocodingService.new(location)
    result.reverse_conn
    result
  end
end
