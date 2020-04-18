class Api::V1::BackgroundsController < ApplicationController
  def show
    service = PhotoService.new(params["location"])

    render json: PhotoSerializer.new(service.photo)
  end
end
