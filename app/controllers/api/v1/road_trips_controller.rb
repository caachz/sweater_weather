class Api::V1::RoadTripsController < ApplicationController

  before_action :authenticate

  def create
  end

  private
    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        User.find_by(token: token)
      end
    end
end
