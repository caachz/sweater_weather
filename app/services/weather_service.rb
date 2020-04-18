class WeatherService
  def initialize(lat, lng)
    @lat = lat
    @lng = lng
    @forecast = Forecast.new(parse_json)
  end

  def conn
    Faraday.new(url: "https://api.openweathermap.org/data/2.5/onecall?lat=#{@lat}&lon=#{@lng}&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
  end

  def get
    conn.get
  end

  def parse_json
    response = get
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
