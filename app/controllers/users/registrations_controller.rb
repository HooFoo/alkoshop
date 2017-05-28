class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    user = User.new user_params
    if set_user_card(user) && user.save
      sign_in(:user, user)
      redirect_to after_sign_up_path_for(user)
    else
      render status: 422, partial: 'shared/form_errors', object: user.errors
    end
  end

  # GET /resource/edit

  # PUT /resource
  def update
    user = current_user
    if set_user_card(user) && user.update_without_password(user_params)
      sign_in(:user, user)
      redirect_to after_sign_up_path_for(user)
    else
      render status: 422, partial: 'shared/form_errors', object: user.errors
    end
  end


  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def set_user_card(user)
    unless params[:user][:discount_card_attributes][:number].empty?
      card = DiscountCard.where(number: params[:user][:discount_card_attributes][:number]).first
      if card && (card.user.nil? || card.user.id == user.id)
        user.discount_card = card
        return true
      else
        user.errors.add('Дисконтная карта', 'не найдена')
        return false
      end
    end
    true
  end

  def user_params
    params.require(:user).permit(:name,:surname,:email,:phone,:country,:district,:city, :password, :password_confirmation)
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,
                                                       :surname,
                                                       :email,
                                                       :phone,
                                                       :country,
                                                       :district,
                                                       :city,
                                                       :password,
                                                       :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name,
                                                              :surname,
                                                              :email,
                                                              :phone,
                                                              :country,
                                                              :district,
                                                              :city,
                                                              :password,
                                                              :password_confirmation])
    devise_parameter_sanitizer.permit(:user, keys: [:name,
                                                              :surname,
                                                              :email,
                                                              :phone,
                                                              :country,
                                                              :district,
                                                              :city,
                                                              :password,
                                                              :password_confirmation])
    end

  #The path used after sign up.
  def after_sign_up_path_for(resource)
    '/profile'
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
