# frozen_string_literal: true

class RenamePictureColumnToImages < ActiveRecord::Migration[5.2]
  def change
    rename_column :images, :picture, :image
  end
end
