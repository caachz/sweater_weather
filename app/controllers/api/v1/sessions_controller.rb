class Api::V1::SessionsController < ApplicationController
  def create
    user = User.where(email: params["email"]).first

    if user&.valid_password?(params["password"])
      render json: UserSerializer.new(user)
    else
      render :json => { :errors => "unauthorized" }, :status => 401
    end
  end
end
