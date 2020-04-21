class GeocodingService

  def geocode_conn(location)
    response = connection.get("/maps/api/geocode/json") do |f|
      f.params["address"] = location
    end

    get_json(response)
  end

  def reverse_conn(location)
    response = connection.get("/maps/api/geocode/json") do |f|
      f.params["latlng"] = location
    end

    get_json(response)
  end

  def location_info(json)
    {lat: json[:results][0][:geometry][:location][:lat],
      lng: json[:results][0][:geometry][:location][:lng],
      name: json[:results][0][:address_components][0][:long_name]}
  end

  private
    def connection
      Faraday.new(url: 'https://maps.googleapis.com') do |faraday|
        faraday.params["key"] = ENV["GOOGLE_API_KEY"]
      end
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
