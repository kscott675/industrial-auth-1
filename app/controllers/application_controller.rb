class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back fallback_location: root_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :private, :name, :bio, :website, :avatar_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :private, :name, :bio, :website, :avatar_image])
  end

  def authorize_profile_access
    unless policy(@user).profile_public?
      flash.now[:alert] = "This user is private."
      respond_to do |format|
        format.html { render "show" }
        format.json { head :no_content }
      end
    end
  end
end
