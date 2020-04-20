class AntipodeFacade
  attr_reader :location_name, :forecast, :search_location, :id

  def initialize(origin)
    origin_coodinates = geocode_origin(origin)
    antipode_coodinates = find_antipode(origin_coodinates.lat, origin_coodinates.lng)
    antipode_weather = get_weather(antipode_coodinates.antipode_lat, antipode_coodinates.antipode_lng)
    current_temp = antipode_weather.forecast.today[:temp_now]
    current_weather = antipode_weather.forecast.today[:today_description]

    @id = "null"
    @forecast = {summary: current_weather, current_temperature: current_temp}
    @search_location = origin
    @location_name = reverse_geocode("#{antipode_coodinates.antipode_lat}, #{antipode_coodinates.antipode_lng}").city_name
  end

  def geocode_origin(origin)
    result = GeocodingService.new(origin)
    result.geocode_conn
    result
  end

  def find_antipode(lat, lng)
    antipode_city = AmypodeService.new(lat, lng)
  end

  def get_weather(lat, lng)
    antipode_weather = WeatherService.new(lat, lng)
  end

  def reverse_geocode(location)
    result = GeocodingService.new(location)
    result.reverse_conn
    result
  end
end
