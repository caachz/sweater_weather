class Api::V1::ForecastsController < ApplicationController
  def show
    facade = ForecastFacade.new(params["location"])

    render :json => weather.parse_json
  end
end
