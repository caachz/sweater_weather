class Api::V1::UsersController < ApplicationController
  def create
    require "pry"; binding.pry
    user = User.where(email: params["email"]).first

    if user.valide_password?(params["password"])
      render json: user.as_json(only: [:id, :email]), status: :created
    else
      head(:unauthorized)
    end
  end
end
