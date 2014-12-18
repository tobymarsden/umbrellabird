class SessionsController < ApplicationController

  def create
    raise "Twitter UID not provided" unless auth_hash[:uid]
    session[:account_uid] = auth_hash[:uid]
    session[:account_image] = auth_hash[:info][:image]
    session[:access_token] = auth_hash[:credentials][:token]
    session[:access_token_secret] = auth_hash[:credentials][:secret]
    redirect_to root_path
  end

  def destroy
    session[:account_uid] = nil
    session[:account_image] = nil
    session[:access_token] = nil
    session[:access_token_secret] = nil
    redirect_to root_path
  end

private

  def auth_hash
    request.env['omniauth.auth']
  end

end
