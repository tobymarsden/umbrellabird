class UsersController < ApplicationController

  before_filter :login_if_no_account_uid
  helper_method :current_account_uid

  def index
    session[:username] = params[:username] if !params[:username].blank?
    if session[:username]  
      @users = twitter.new_followers(session[:username])
    else
      @users = []
    end
  end

  def follow
    twitter.follow(params[:id].try(:to_i))
    User.follow(params[:id], current_account_uid)
    head status: :ok
  end

  def ignore
    User.ignore(params[:id], current_account_uid)
    head status: :ok
  end

end
