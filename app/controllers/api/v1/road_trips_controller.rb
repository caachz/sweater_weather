class Api::V1::RoadTripsController < ApplicationController
  before_action :authenticate

  def create
    facade = RoadtripFacade.new(params["origin"], params["destination"])

    render json: RoadtripSerializer.new(facade)
  end

  private
    def authenticate
      user = User.find_by(authentication_token: params["api_key"])

      if user
        @current_user = user
      else
        render status: 401
      end
    end
end
