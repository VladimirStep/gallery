class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  prepend_before_action :check_captcha, only: [:create], unless: -> { cookies[:skip_recaptcha] == 'true' }

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    current_user.events.last.update_attribute(:confirmation, true) if user_signed_in?
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  def destroy
    @user = current_user
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    if signed_out
      set_flash_message! :notice, :signed_out
      @user.events.last.update_attribute(:confirmation, true)
    end
    yield if block_given?
    respond_to_on_destroy
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_in_params
      respond_with_navigational(resource) { render :new }
    end
  end
end
