# frozen_string_literal: true

class AdvertisementPolicy < ApplicationPolicy
  def new?
    user.present? && !user.admin?
  end
  alias create? new?

  def edit?
    !user.admin? &&
      user == record.user &&
      record.status.in?(%w[draft pending_review])
  end
  alias update? edit?
  alias destroy? edit?

  def moderate?
    user.present? && user.admin?
  end
end
