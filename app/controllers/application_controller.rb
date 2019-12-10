# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: :json_request?
  protect_from_forgery with: :null_session, if: :json_request?
  skip_before_action :verify_authenticity_token, if: :json_request?

  rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_auth_token

  before_action :set_current_user, if: :json_request?

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if current_user.role
        super
      else
        edit_role_profile_path
      end
  end

  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: (I18n.locale == I18n.default_locale ? nil : I18n.locale) }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  rescue_from CanCan::AccessDenied do
    redirect_to edit_role_profile_path unless current_user.role?

    raise(CanCan::AccessDenied)
  end

  private

  def json_request?
    request.format.json?
  end

  # Use api_user Devise scope for JSON access
  def authenticate_user!(*args)
    super and return unless args.blank?
    json_request? ? authenticate_api_user! : super
  end

  def invalid_auth_token
    respond_to do |format|
      format.html { redirect_to sign_in_path,
                    error: 'Login invalid or expired' }
      format.json { head 401 }
    end
  end

  # So we can use Pundit policies for api_users
  def set_current_user
    @current_user ||= warden.authenticate(scope: :api_user)
  end
end
