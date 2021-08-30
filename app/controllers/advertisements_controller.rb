# frozen_string_literal: true

class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all
  end
end
