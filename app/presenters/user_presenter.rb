# frozen_string_literal: true

class UserPresenter
  def initialize(user)
    @user = user
  end

  delegate :first_name, :last_name, :id, :email, to: :user

  def display_name
    if user.first_name.present? || user.last_name.present?
      [user.first_name, user.last_name].join(' ').strip
    else
      user.email
    end
  end

  private

  attr_reader :user
end
