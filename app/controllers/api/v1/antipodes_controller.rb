class Api::V1::AntipodesController < ApplicationController
  def show
    info = AntipodeFacade.new(params["location"])

    render json: AntipodeSerializer.new(info)
  end
end
