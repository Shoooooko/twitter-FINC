class Post < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, length: { maximum: 200 }
  validates :title, presence: true
  has_many :comments, dependent: :destroy
  has_many :fav_posts, dependent: :destroy
  has_many :images, dependent: :destroy

  def images_limit(post)
    images = Image.where(post_id: post.id)
    if images.count <= 3
      return true
    else
      return false
    end
  end
end
