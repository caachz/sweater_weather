class Api::V1::AntipodesController < ApplicationController
  def show

    origin_coordinates = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?address=#{params["location"]}&key=#{ENV["GOOGLE_API_KEY"]}")

    origin_coordinates_response = origin_coordinates.get
    origin_coordinates_json = JSON.parse(origin_coordinates_response.body, symbolize_names: true)
    origin_lat = origin_coordinates_json[:results][0][:geometry][:location][:lat]
    origin_lng = origin_coordinates_json[:results][0][:geometry][:location][:lng]

    require "pry"; binding.pry
  end
end
