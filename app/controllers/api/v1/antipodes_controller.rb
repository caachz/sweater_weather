class Api::V1::AntipodesController < ApplicationController
  def show
    origin = GeocodingService.new(params["location"])
    origin.geocode_conn

    antipode_city = AmypodeService.new(origin.lat, origin.lng)
    antipode_weather = WeatherService.new(antipode_city.antipode_lat, antipode_city.antipode_lng)

    reverse = GeocodingService.new("#{antipode_city.antipode_lat}, #{antipode_city.antipode_lng}")

    reverse.reverse_conn
    # antipod_name = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{antipode_city.antipode_lat},#{antipode_city.antipode_lng}&key=#{ENV["GOOGLE_API_KEY"]}")
    # antipod_name_result = antipod_name.get
    # antipod_name_json = JSON.parse(antipod_name_result.body, symbolize_names: true)
    # antipod_name = antipod_name_json[:results][0][:address_components][1][:long_name] + ', ' + antipod_name_json[:results][0][:address_components][-1][:long_name]

    render json: {
    "data": {
        "id": "null",
        "type": "antipode",
        "attributes": {
            "location_name": reverse.city_name,
            "forecast": {
                "summary": antipode_weather.forecast.today[:today_description],
                "current_temperature": antipode_weather.forecast.today[:temp_now],
            },
            "search_location": params["location"]
        }
    }
}
  end
end
