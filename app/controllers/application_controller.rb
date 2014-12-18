class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_account_image

  def login_if_no_account_uid
    redirect_to '/auth/twitter' unless current_account_uid
  end

  def twitter
    @bot ||= TwitterBot.new(access_token: session[:access_token], access_token_secret: session[:access_token_secret], account_uid: current_account_uid)
  end

  def current_account_uid
    session[:account_uid]
  end

  def current_account_image
    session[:account_image]
  end

end
