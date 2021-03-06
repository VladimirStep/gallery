class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :track_user

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def self.default_url_options(options={})
    options.merge({ :locale => I18n.locale })
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || categories_path
  end

  def track_user
    Event.create!(url: request.env['REQUEST_PATH'], user_id: current_user.id) if user_signed_in?
  end
end
