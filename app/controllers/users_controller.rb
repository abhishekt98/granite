# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    users = User.all.as_json(only: %i[id name])
    render status: :ok, json: { users: users }
  end

  def create
    puts user_params
    @user = User.new(user_params)
    if @user.save
      render status: :ok, json: { notice: t("successfully_created", entity: "User") }
    else
      render status: :unprocessable_entity,
        json: { error: @user.errors.full_messages.to_sentence }
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
