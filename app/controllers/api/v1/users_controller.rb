class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(email: params["email"], password: params["password"], password_confirmation: params["password_confirmation"])

    if user.save
      render json: user.as_json(only: [:id, :email, :authentication_token]), status: :created
    else
      render :json => { :errors => "user cannot be created with these credentials" }, :status => 401
    end
  end
end
