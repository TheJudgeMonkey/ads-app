# frozen_string_literal: true

class AddCategoryIdToAdvertisements < ActiveRecord::Migration[6.1]
  def change
    add_column :advertisements, :category_id, :bigint
  end
end
