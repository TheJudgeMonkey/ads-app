# frozen_string_literal: true

module Advertisements
  class DeleteFileController < ApplicationController
    def destroy
      authorize current_advertisement
      current_advertisement.files.find(params[:id]).purge
      redirect_back(fallback_location: advertisements_path)
    end

    private

    def current_advertisement
      Advertisement.find(params[:advertisement_id])
    end
  end
end
