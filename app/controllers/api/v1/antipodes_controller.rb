class Api::V1::AntipodesController < ApplicationController
  def show

    origin_coordinates = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?address=#{params["location"]}&key=#{ENV["GOOGLE_API_KEY"]}")

    origin_coordinates_response = origin_coordinates.get
    origin_coordinates_json = JSON.parse(origin_coordinates_response.body, symbolize_names: true)
    origin_lat = origin_coordinates_json[:results][0][:geometry][:location][:lat]
    origin_lng = origin_coordinates_json[:results][0][:geometry][:location][:lng]

    antipode_city = Faraday.new(url: "http://amypode.herokuapp.com/api/v1/antipodes?lat=#{origin_lat}&long=#{origin_lng}")

    antipod_result = antipode_city.get('', {}, {api_key: ENV["AMYPODE_API_KEY"]})
    antipod_json = JSON.parse(antipod_result.body, symbolize_names: true)
    antipod_lat = antipod_json[:data][:attributes][:lat]
    antipod_lng = antipod_json[:data][:attributes][:long]

    
  end
end
