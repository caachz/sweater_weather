class GeocodingService

  def geocode_conn(location)
    conn = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{ENV['GOOGLE_API_KEY']}")

    response = conn.get
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def reverse_conn(location)
    conn = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{location}&key=#{ENV["GOOGLE_API_KEY"]}")

    response = conn.get
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def location_info(json)
    {lat: json[:results][0][:geometry][:location][:lat],
      lng: json[:results][0][:geometry][:location][:lng],
      name: json[:results][0][:address_components][0][:long_name]}
  end
end
