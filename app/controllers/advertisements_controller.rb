# frozen_string_literal: true

class AdvertisementsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @q = Advertisement.published.ransack(params[:q])
    @advertisements = @q.result.includes(:category, :user, files_attachments: :blob).pagination(params[:page])
  end

  def show
    @advertisement = Advertisement.find(params[:id])
  end

  def new
    @advertisement = current_user.advertisements.new
    authorize @advertisement
  end

  def create
    @advertisement = current_user.advertisements.new(advertisement_params)

    authorize @advertisement

    @advertisement.status = params[:advertisement][:draft] == '1' ? :draft : :pending_review

    if @advertisement.save
      redirect_to advertisement_path(@advertisement.id), notice: t('.notice')
    else
      render :new
    end
  end

  def edit
    @advertisement = Advertisement.find(params[:id])
    authorize @advertisement
  end

  def update
    @advertisement = Advertisement.find(params[:id])

    authorize @advertisement

    @advertisement.status = params[:advertisement][:draft] == '1' ? :draft : :pending_review

    if @advertisement.update(advertisement_params)
      redirect_to advertisement_path(@advertisement.id), notice: t('.notice')
    else
      render :edit
    end
  end

  def destroy
    @advertisement = Advertisement.find(params[:id])

    authorize @advertisement

    @advertisement.destroy

    redirect_to advertisements_path, notice: t('.notice')
  end

  private

  def advertisement_params
    params.require(:advertisement).permit(:title, :description, :category_id, files: [])
  end
end
