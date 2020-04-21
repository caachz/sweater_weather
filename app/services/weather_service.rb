class WeatherService

  def initialize(lat, lng)
    @lat = lat
    @lng = lng
  end

  def get_forecast
    response = connection.get("/data/2.5/onecall") do |f|
      f.params["lat"] = @lat
      f.params["lon"] = @lng
      f.params["appid"] = ENV['OPEN_WEATHER_API_KEY']
    end

    get_json(response)
  end

  private
    def connection
      Faraday.new(url: 'https://api.openweathermap.org')
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
