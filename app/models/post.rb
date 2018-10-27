class Post < ApplicationRecord
  belongs_to :user
  validates :body,  {presence: true, length: {maximum: 200}}
  validates :title,presence: true
  has_many :comments, dependent: :delete_all
  has_many :fav_posts, dependent: :delete_all
end
