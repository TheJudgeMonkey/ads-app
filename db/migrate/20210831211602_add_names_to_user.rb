# frozen_string_literal: true

class AddNamesToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :first_name, null: true
      t.string :last_name, null: true
    end
  end
end
