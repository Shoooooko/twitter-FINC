# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, length: {maximum: 200}
  has_many :comments, dependent: :destroy
  has_many :fav_posts, dependent: :destroy
  has_many :images, dependent: :destroy

  def images_limit?
    images.count <= 3
  end
end
