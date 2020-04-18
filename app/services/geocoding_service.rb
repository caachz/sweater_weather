class GeocodingService
  attr_reader :lat, :lng

  def initialize(location)
    @location = location
    @lat = parse_json[:results][0][:geometry][:location][:lat]
    @lng = parse_json[:results][0][:geometry][:location][:lng]
  end

  def conn
    geocoding_conn = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?address=#{@location}&key=#{ENV['GOOGLE_API_KEY']}")
  end

  def get
    conn.get
  end

  def parse_json
      response = get
      JSON.parse(response.body, symbolize_names: true)
  end
end
