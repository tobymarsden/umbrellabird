class User < ActiveRecord::Base

  def self.follow(id, account_uid)
    user = User.find_or_build(id, account_uid)
    user.followed_at = Time.now
    user.save
  end

  def self.unfollow(id, account_uid)
    user = User.find_or_build(id, account_uid)
    user.unfollowed_at = Time.now
    user.save
  end

  def self.follow_ignore(id, account_uid)
    user = User.find_or_build(id, account_uid)
    user.follow_ignored_at = Time.now
    user.save
  end

  def self.unfollow_ignore(id, account_uid)
    user = User.find_or_build(id, account_uid)
    user.unfollow_ignored_at = Time.now
    user.save
  end

  def self.find_or_build(id, account_uid)
    user = User.find_by_user_id_and_account_uid(id, account_uid)
    user ||= User.new(user_id: id, account_uid: account_uid)
  end

  def self.following_or_follow_ignoring?(id, account_uid)
    user = User.find_by_user_id_and_account_uid(id, account_uid)
    user && (user.follow_ignored_at || user.followed_at)
  end

  def self.user_ids_not_following_or_follow_ignored(user_ids, account_uid)
    user_ids - User.where(account_uid: account_uid).where('followed_at IS NOT NULL OR follow_ignored_at IS NOT NULL').where(user_id: user_ids).pluck(:user_id)
  end

  def self.user_ids_not_unfollow_ignored_or_followed_recently(user_ids, account_uid)
    user_ids - User.where(account_uid: account_uid).where(['followed_at > ? OR unfollow_ignored_at IS NOT NULL', 4.days.ago]).where(user_id: user_ids).pluck(:user_id)
  end
end
