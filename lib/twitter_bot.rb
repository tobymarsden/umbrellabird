class TwitterBot

  def initialize(args)
    @access_token = args[:access_token]
    @access_token_secret = args[:access_token_secret]
    @account_uid = args[:account_uid]
  end

  def twitter
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = @access_token
      config.access_token_secret = @access_token_secret
    end
  end

  def new_followers(username)
    user_ids = twitter.follower_ids(username).take(5000)
    twitter.users(User.user_ids_not_following_or_follow_ignored(user_ids, @account_uid).slice(0,100))
  end

  def unfollowers
    user_ids = twitter.friend_ids.take(5000) - twitter.follower_ids.take(5000)
    Rails.logger.info "user_ids:"
    Rails.logger.info user_ids
    users = twitter.users(User.user_ids_not_unfollow_ignored_or_followed_recently(user_ids, @account_uid).slice(0,100))
    Rails.logger.info "twitter: "
    Rails.logger.info twitter
    Rails.logger.info "users:"
    Rails.logger.info users.inspect
    users
  end

  def follow(twitter_user_id)
    twitter.follow!(twitter_user_id)
  end

  def unfollow(twitter_user_id)
    twitter.unfollow(twitter_user_id)
  end

  def user(username)
    twitter.user(username) rescue nil
  end

end
