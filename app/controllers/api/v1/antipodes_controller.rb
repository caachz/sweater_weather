class Api::V1::AntipodesController < ApplicationController
  def show
    origin = GeocodingService.new(params["location"])
    origin.parse_json
    # origin_coordinates = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?address=#{params["location"]}&key=#{ENV["GOOGLE_API_KEY"]}")
    # origin_coordinates_response = origin_coordinates.get
    # origin_coordinates_json = JSON.parse(origin_coordinates_response.body, symbolize_names: true)
    # origin_lat = origin_coordinates_json[:results][0][:geometry][:location][:lat]
    # origin_lng = origin_coordinates_json[:results][0][:geometry][:location][:lng]

    antipode_city = Faraday.new(url: "http://amypode.herokuapp.com/api/v1/antipodes?lat=#{origin.lat}&long=#{origin.lng}")
    antipod_result = antipode_city.get('', {}, {api_key: ENV["AMYPODE_API_KEY"]})
    antipod_json = JSON.parse(antipod_result.body, symbolize_names: true)
    antipod_lat = antipod_json[:data][:attributes][:lat]
    antipod_lng = antipod_json[:data][:attributes][:long]

    antipod_weather = Faraday.new(url: "https://api.openweathermap.org/data/2.5/onecall?lat=#{antipod_lat}&lon=#{antipod_lng}&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
    antipod_weather_result = antipod_weather.get
    antipod_weather_json = JSON.parse(antipod_weather_result.body, symbolize_names: true)
    antipod_summary = antipod_weather_json[:current][:weather][0][:description]
    antipod_current_temp = antipod_weather_json[:current][:temp]

    antipod_name = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{antipod_lat},#{antipod_lng}&key=#{ENV["GOOGLE_API_KEY"]}")
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
