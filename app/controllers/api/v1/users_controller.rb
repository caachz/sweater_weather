class Api::V1::UsersController < ApplicationController
  def create
    user_info = JSON.parse(params.keys.first, symbolize_names: true)

    user = User.new(email: user_info[:email], password: user_info[:password], password_confirmation: user_info[:password_confirmation])

    if user.save
      render json: user.as_json(only: [:id, :email, :authentication_token]), status: :created
    else
      head(:unauthorized)
    end
  end
end
