class User < ActiveRecord::Base

  def self.follow(id, account_uid)
    user = User.find_or_build(id, account_uid)
    user.followed_at = Time.now
    user.save
  end

  def self.ignore(id, account_uid)
    user = User.find_or_build(id, account_uid)
    user.ignored_at = Time.now
    user.save
  end

  def self.find_or_build(id, account_uid)
    user = User.find_by_user_id_and_account_uid(id, account_uid)
    user ||= User.new(user_id: id, account_uid: account_uid)
  end

  def self.following_or_ignoring?(id, account_uid)
    user = User.find_by_user_id_and_account_uid(id, account_uid)
    user && (user.ignored_at || user.followed_at)
  end

  def self.user_ids_not_following_or_ignored(user_ids, account_uid)
    user_ids - User.where(account_uid: account_uid).where('followed_at IS NOT NULL OR ignored_at IS NOT NULL').where(user_id: user_ids).pluck(:user_id)
  end

end
