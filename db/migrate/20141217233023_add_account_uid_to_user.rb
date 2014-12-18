class AddAccountIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :account_uid, :integer, limit: 8
  end
end
