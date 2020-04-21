class AmypodeService
  attr_reader :lat, :lng

  def initialize(lat, lng)
    @origin_lat = lat
    @origin_lng = lng
    @lat = get_data[:data][:attributes][:lat]
    @lng = get_data[:data][:attributes][:long]
  end

  def get_data
    response = connection.get("/api/v1/antipodes") do |f|
      f.params["lat"] = @origin_lat
      f.params["long"] = @origin_lng
      f.headers["api_key"] = ENV["AMYPODE_API_KEY"]
    end

    get_json(response)
  end

  private
    def connection
      Faraday.new(url: 'http://amypode.herokuapp.com')
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
