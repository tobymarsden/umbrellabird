class AddIndices < ActiveRecord::Migration
  def change
    add_index :users, :followed_at
    add_index :users, :ignored_at
    add_index :users, :account_uid
  end
end
