class AmypodeService
  attr_reader :antipode_lat, :antipode_lng

  def initialize(lat, lng)
    @origin_lat = lat
    @origin_lng = lng
    @antipode_lat = parse_json[:data][:attributes][:lat]
    @antipode_lng = parse_json[:data][:attributes][:long]
  end

  def conn
    Faraday.new(url: "http://amypode.herokuapp.com/api/v1/antipodes?lat=#{@origin_lat}&long=#{@origin_lng}")
  end

  def get
    conn.get('', {}, {api_key: ENV["AMYPODE_API_KEY"]})
  end

  def parse_json
    response = get
    JSON.parse(response.body, symbolize_names: true)
  end
end
