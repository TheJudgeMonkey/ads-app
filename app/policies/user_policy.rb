# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.present? && user.admin?
  end

  def edit?
    user.admin? || user == record
  end
  alias update? edit?
  alias destroy? edit?

  def password_change?
    user == record
  end

  def permitted_attributes
    if user.admin?
      %i[first_name last_name password password_confirmation role]
    elsif user == record
      %i[first_name last_name password password_confirmation]
    end
  end
end
