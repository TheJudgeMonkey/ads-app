# frozen_string_literal: true

class CreateAdvertisements < ActiveRecord::Migration[6.1]
  def change
    create_table :advertisements do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :status, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
