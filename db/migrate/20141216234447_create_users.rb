class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :user_id, limit: 8
      t.datetime  :followed_at
      t.datetime  :unfollowed_at
      t.datetime  :ignored_at

      t.timestamps
    end
  end
end
