class AmypodeService
  attr_reader :lat, :lng

  def initialize(lat, lng)
    @origin_lat = lat
    @origin_lng = lng
    @lat = get_data[:data][:attributes][:lat]
    @lng = get_data[:data][:attributes][:long]
  end

  # def coordinates
  #   "#{@lat}, #{@lng}"
  # end

  def conn
    Faraday.new(url: "http://amypode.herokuapp.com/api/v1/antipodes?lat=#{@origin_lat}&long=#{@origin_lng}")
  end

  def get
    conn.get('', {}, {api_key: ENV["AMYPODE_API_KEY"]})
  end

  def get_data
    response = get
    JSON.parse(response.body, symbolize_names: true)
  end
end
