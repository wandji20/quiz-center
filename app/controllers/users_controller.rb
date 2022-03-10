class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create
  
  def create
    @user = User.new(user_params)
    if @user.save
      token = JsonWebToken.encode(user_id: @user.id)
      json_response({ Authorization: token }, :created)
    else
      json_response({ errors: @user.errors.full_messages }, :unprocessable_entity)
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end
end
