# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def edit?
    user.admin? || user == record
  end
  alias update? edit?
  alias destroy? edit?

  def password_change?
    user == record
  end
end
