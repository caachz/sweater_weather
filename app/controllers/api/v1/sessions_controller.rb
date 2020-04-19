class Api::V1::SessionsController < ApplicationController
  def create
    user_info = JSON.parse(params.keys.first, symbolize_names: true)

    user = User.where(email: user_info[:email]).first

    if user&.valid_password?(user_info[:password])
      render json: user.as_json(only: [:email, :authentication_token]), status: :created
    else
      render :json => { :errors => "unauthorized" }, :status => 401
    end
  end
end
