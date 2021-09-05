# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def new?
    user.present? && user.admin?
  end
  alias create? new?
  alias update? new?
  alias destroy? new?
  alias edit? new?
end
