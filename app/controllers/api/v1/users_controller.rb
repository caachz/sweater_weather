class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(email: params["email"], password: params["password"], password_confirmation: params["password_confirmation"])
    if user.save
      render json: user.as_json(only: [:id, :email, :authentication_token]), status: :created
    # elsif user&.valid_password?(params["password"])
    #   render json: user.as_json(only: [:id, :email, :authentication_token]), status: :created
    else
      head(:unauthorized)
    end
  end
end
