class AddIndexColumnToFollows < ActiveRecord::Migration[5.2]
  def change
  end
  #add_index :follows, :follower_user_id
  #add_index :follows, :followed_user_id
  #add_index :followss, [:follower_user_id, :followed_user_id], unique: true
end
