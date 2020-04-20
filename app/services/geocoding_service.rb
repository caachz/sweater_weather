class GeocodingService
  attr_reader :lat, :lng, :city_name

  def initialize(location)
    @location = location
    @lat = nil
    @lng = nil
    @city_name = nil
  end

  def geocode_conn
    conn = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?address=#{@location}&key=#{ENV['GOOGLE_API_KEY']}")

    response = get(conn)
    @lat = response[:results][0][:geometry][:location][:lat]
    @lng = response[:results][0][:geometry][:location][:lng]
  end

  def reverse_conn
    conn = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{@location}&key=#{ENV["GOOGLE_API_KEY"]}")

    response = get(conn)
    @city_name = response[:results][0][:address_components][1][:long_name] + ", " + response[:results][0][:address_components][-1][:long_name]
  end

  def get(conn)
    response = conn.get
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
