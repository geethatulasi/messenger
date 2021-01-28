class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :mailbox
  helper_method :conversation 

  private
  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id]) if params[:id]
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:name,:email,:password,:password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name,:email,:password,:password_confirmation,:current_password])
  end
end
