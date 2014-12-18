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
    twitter.users(User.user_ids_not_following_or_ignored(user_ids, @account_uid).slice(0,100))
  end

  def follow(twitter_user_id)
    twitter.follow!(twitter_user_id)
  end

end