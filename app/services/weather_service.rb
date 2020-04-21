class WeatherService
  attr_reader :forecast

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

  def arrival_forecast(duration)
    current_time = @forecast.params[:current][:dt]
    arrival_time = current_time + duration

    forecast = @forecast.params[:hourly].min_by do |time|
      (arrival_time - time[:dt]).abs
    end

    weather = forecast[:weather][0][:description]
    temp = forecast[:temp]
    {temp: temp, description: weather}
  end
end
