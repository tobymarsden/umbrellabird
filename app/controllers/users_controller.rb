class UsersController < ApplicationController

  before_filter :login_if_no_account_uid
  helper_method :current_account_uid

  def index
    session[:username] = params[:username].gsub(' ', '') if !params[:username].blank?
    if session[:username] && twitter.user(session[:username])
      @users = twitter.new_followers(session[:username])
    else
      flash[:error] = "Couldn't find Twitter user @#{session[:username]}" if session[:username]
      @users = []
    end
  end

  def unfollowers
    @users = twitter.unfollowers
  end

  def follow
    twitter.follow(params[:id].try(:to_i))
    User.follow(params[:id], current_account_uid)
    head status: :ok
  end

  def unfollow
    twitter.unfollow(params[:id].try(:to_i))
    User.unfollow(params[:id], current_account_uid)
    head status: :ok
  end

  def follow_ignore
    User.follow_ignore(params[:id], current_account_uid)
    head status: :ok
  end

  def unfollow_ignore
    User.unfollow_ignore(params[:id], current_account_uid)
    head status: :ok
  end

end
