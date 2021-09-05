# frozen_string_literal: true

class RemovePicturesFromAdvertisemenets < ActiveRecord::Migration[6.1]
  def change
    remove_column :advertisements, :pictures, :json
  end
end
