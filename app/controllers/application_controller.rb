class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?

  protected
  def not_found
    raise ActiveRecord::RecordNotFound
  rescue StandardError
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
  end

  def show_flash_error object_error
    object_error.errors.full_messages.each do |msg|
      flash[:notice] = msg
    end
  end

  def user_logged_in
    unless user_signed_in?
      render :js => "window.location = '#{new_user_session_path}'"
    end
  end

  private
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? &&
      !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
