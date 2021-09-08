# frozen_string_literal: true

class UsersController < ApplicationController
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

    authorize @user

    @user.role = params[:user][:admin] == '1' ? :admin : :user

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
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation)
  end
end
