# frozen_string_literal: true

class AdvertisementPolicy < ApplicationPolicy
  def new?
    user.present? && !user.admin?
  end
  alias create? new?

  def edit?
    user == record.user &&
      record.status.in?(%w[draft rejected archived])
  end
  alias update? edit?

  def destroy?
    user.admin? &&
      record.status.in?(%w[published]) ||
      user == record.user
  end

  def moderate?
    user.present? && user.admin?
  end
end
