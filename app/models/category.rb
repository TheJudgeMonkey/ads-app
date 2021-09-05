# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :advertisements, dependent: :destroy

  validates :name, presence: true
end
