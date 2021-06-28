class ApplicationController < ActionController::Base
  before_action :authenticate_user!,  only: [:create, :edit, :destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :profile, :name, :occupation, :position])
  end
end
