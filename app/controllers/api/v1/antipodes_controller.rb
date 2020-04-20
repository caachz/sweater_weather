class Api::V1::AntipodesController < ApplicationController
  def show
    origin = GeocodingService.new(params["location"])

    antipode_city = AmypodeService.new(origin.lat, origin.lng)

    # antipode_city = Faraday.new(url: "http://amypode.herokuapp.com/api/v1/antipodes?lat=#{origin.lat}&long=#{origin.lng}")
    # antipod_result = antipode_city.get('', {}, {api_key: ENV["AMYPODE_API_KEY"]})
    # antipod_json = JSON.parse(antipod_result.body, symbolize_names: true)
    # antipod_lat = antipod_json[:data][:attributes][:lat]
    # antipod_lng = antipod_json[:data][:attributes][:long]

    antipod_weather = Faraday.new(url: "https://api.openweathermap.org/data/2.5/onecall?lat=#{antipode_city.antipode_lat}&lon=#{antipode_city.antipode_lng}&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
    antipod_weather_result = antipod_weather.get
    antipod_weather_json = JSON.parse(antipod_weather_result.body, symbolize_names: true)
    antipod_summary = antipod_weather_json[:current][:weather][0][:description]
    antipod_current_temp = antipod_weather_json[:current][:temp]

    antipod_name = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{antipode_city.antipode_lat},#{antipode_city.antipode_lng}&key=#{ENV["GOOGLE_API_KEY"]}")
    antipod_name_result = antipod_name.get
    antipod_name_json = JSON.parse(antipod_name_result.body, symbolize_names: true)
    antipod_name = antipod_name_json[:results][0][:address_components][1][:long_name] + ', ' + antipod_name_json[:results][0][:address_components][-1][:long_name]

    render json: {
    "data": {
        "id": "null",
        "type": "antipode",
        "attributes": {
            "location_name": antipod_name,
            "forecast": {
                "summary": antipod_summary,
                "current_temperature": antipod_current_temp,
            },
            "search_location": params["location"]
        }
    }
}
  end
end
