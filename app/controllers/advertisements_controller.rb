# frozen_string_literal: true

class AdvertisementsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @advertisements = Advertisement.order(updated_at: :desc).page(params[:page]).per(6)
  end

  def show
    @advertisement = Advertisement.find(params[:id])
  end

  def new
    @advertisement = current_user.advertisements.new
  end

  def create
    @advertisement = current_user.advertisements.new(advertisement_params)

    @advertisement.status = params[:advertisement][:draft] == '1' ? :draft : :pending_review

    if @advertisement.save
      redirect_to advertisement_path(@advertisement.id), notice: 'Advertisement was successfully created.'
    else
      render :new
    end
  end

  def edit
    @advertisement = Advertisement.find(params[:id])
  end

  def update
    @advertisement = current_user.advertisements.find(params[:id])

    @advertisement.status = params[:advertisement][:draft] == '1' ? :draft : :pending_review

    if @advertisement.update(advertisement_params)
      redirect_to advertisement_path(@advertisement.id), notice: 'Advertisement was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    Advertisement.find(params[:id]).destroy!
    redirect_to advertisements_path, notice: 'Advertisement was successfully destroyed.'
  end

  private

  def advertisement_params
    params.require(:advertisement).permit(:title, :description)
  end
end
