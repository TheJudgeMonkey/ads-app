# frozen_string_literal: true

module Moderations
  class AdvertisementsController < ApplicationController
    def index
      authorize Advertisement, :moderate?
      @advertisements = Advertisement.pending_review.pagination(params[:page])
    end

    def show
      authorize current_advertisement, :moderate?
      @advertisement = current_advertisement
    end

    def update
      authorize current_advertisement, :moderate?
      current_advertisement.approve!
      redirect_to moderations_advertisements_path
    end

    def destroy
      authorize current_advertisement, :moderate?
      current_advertisement.reject!
      redirect_to moderations_advertisements_path
    end

    private

    def current_advertisement
      Advertisement.find(params[:id])
    end
  end
end
