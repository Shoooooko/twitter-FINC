# frozen_string_literal: true

class RenameFollowerColumnToFollows < ActiveRecord::Migration[5.2]
  def change
    rename_column :follows, :follower, :follower_user_id
    rename_column :follows, :followed, :followed_user_id
  end
end
