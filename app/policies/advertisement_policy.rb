# frozen_string_literal: true

class AdvertisementPolicy < ApplicationPolicy
  def new?
    user.present?
  end
  alias create? new?

  def edit?
    user.admin? ||
      user == record.user &&
        record.status.in?(%w[draft pending_review])
  end
  alias update? edit?

  def destroy?
    user.admin? || user == record.user
  end

  def approve?
    user.admin?
  end
end
