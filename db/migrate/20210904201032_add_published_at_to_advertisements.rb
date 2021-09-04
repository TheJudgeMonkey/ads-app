# frozen_string_literal: true

class AddPublishedAtToAdvertisements < ActiveRecord::Migration[6.1]
  def change
    add_column :advertisements, :published_at, :datetime
  end
end
