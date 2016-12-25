class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def template
    render template: "templates/#{params[:name]}",layout: false
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def set_user
    @user = current_user || User.new
  end
end
