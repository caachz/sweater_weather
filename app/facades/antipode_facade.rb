class AntipodeFacade
  attr_reader :id

  def initialize(origin)
    @origin = origin
    @geocode = GeocodingService.new
    @id = "null"
    # @start_location = Location.new(@geocode.location_info(geocode_conn(origin))

    # @antipode_name =
    # origin_coodinates = geocode_origin(origin)
    # antipode_coodinates = find_antipode(origin_coodinates.lat, origin_coodinates.lng)
    # antipode_weather = get_weather(antipode_coodinates.antipode_lat, antipode_coodinates.antipode_lng)
    # current_temp = antipode_weather.forecast.today[:temp_now]
    # current_weather = antipode_weather.forecast.today[:today_description]
    #
    # @id = "null"
    # @forecast = {summary: current_weather, current_temperature: current_temp}
    # @search_location = origin
    # @location_name = reverse_geocode("#{antipode_coodinates.antipode_lat}, #{antipode_coodinates.antipode_lng}").city_name
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

  # def geocode_origin(origin)
  #   result = GeocodingService.new(origin)
  #   result.geocode_conn
  #   result
  # end
  #
  # def find_antipode(lat, lng)
  #   antipode_city = AmypodeService.new(lat, lng)
  # end
  #
  # def get_weather(lat, lng)
  #   antipode_weather = WeatherService.new(lat, lng)
  # end
  #
  # def reverse_geocode(location)
  #   result = GeocodingService.new(location)
  #   result.reverse_conn
  #   result
  # end
end
