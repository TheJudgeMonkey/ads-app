# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    @advertisements = @user.advertisements.pagination(params[:page])
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])

    params[:user][:role] = params.dig(:user, :admin) == '1' ? :admin : :user

    authorize @user

    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: t('.notice')
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    authorize @user

    @user.destroy

    redirect_to root_path, notice: t('.notice')
  end

  private

  def user_params
    params.require(:user).permit(policy(@user).permitted_attributes)
  end
end
