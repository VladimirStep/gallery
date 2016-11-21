class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :track_user

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || categories_path
  end

  def track_user
    if user_signed_in?
      unless user_session["track_user"].nil?
        user_session["track_user"] += " #{env["REQUEST_PATH"]}"
      else
        user_session["track_user"] = env["REQUEST_PATH"]
      end
    end
  end
end
