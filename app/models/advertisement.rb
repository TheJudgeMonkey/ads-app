# frozen_string_literal: true

class Advertisement < ApplicationRecord
  include AASM

  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true

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

    event :aprove do
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
