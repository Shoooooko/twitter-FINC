# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, length: { maximum: 200 }
  validates :title, presence: true
  has_many :comments, dependent: :destroy
  has_many :fav_posts, dependent: :destroy
  has_many :images, dependent: :destroy
  # mount_uploader :picture, PictureUploader

  def check_number
    puts 'pic_num_check'
    unless Post.images.count <= 3
      errors.add("登録可能な写真は3枚までです。") # エラーメッセージ
      redirect_to posts_path
    end
  end
end
