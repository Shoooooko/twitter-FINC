# frozen_string_literal: true

class CreateFavPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :fav_posts do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
