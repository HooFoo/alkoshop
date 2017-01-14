class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  def create
    super
    @order.user = current_user
    @order.save
  end
  protected

  def after_sign_in_path_for(resource)
    '/#profile'
  end

  def  after_sign_out_path_for(resource)
    '/#profile'
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
