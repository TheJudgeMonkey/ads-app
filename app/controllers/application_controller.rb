# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  before_action :switch_locale
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = t('alert')
    redirect_to root_path
  end

  def switch_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
