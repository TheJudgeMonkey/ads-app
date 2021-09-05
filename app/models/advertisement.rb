# frozen_string_literal: true

class Advertisement < ApplicationRecord
  include AASM

  has_many_attached :files

  belongs_to :category

  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true

  scope :pagination, ->(page) { order(updated_at: :desc).page(page).per(6) }

  aasm(:status) do
    state :draft
    state :pending_review
    state :approved
    state :rejected
    state :published
    state :archived

    event :send_to_review do
      transitions from: :draft, to: :pending_review
    end

    event :approve do
      transitions from: :pending_review, to: :approved
    end

    event :reject do
      transitions from: :pending_review, to: :rejected
    end

    event :publish do
      transitions from: :approved, to: :published
    end

    event :archive do
      transitions to: :archived
    end
  end
end
