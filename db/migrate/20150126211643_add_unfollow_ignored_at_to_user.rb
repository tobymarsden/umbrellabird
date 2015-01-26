class AddUnfollowIgnoredAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :unfollow_ignored_at, :datetime
    rename_column :users, :ignored_at, :follow_ignored_at
  end
end
