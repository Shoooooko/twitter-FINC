# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :trans, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
