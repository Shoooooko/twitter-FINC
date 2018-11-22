# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :fav_posts, dependent: :destroy
  has_many :fav_comments, dependent: :destroy
  has_one :profile

  def follow?(user)
    Follow.where(follower: self,followed: user).present?
  end

  #userをfollowしているか
  def followed?(user)
    Follow.where(follower: user,followed: self).present?
  end

  def find_pfav?(post)
     self.fav_posts.where(post_id: post.id).exists?
  end

  def find_cfav?(comment)
    self.fav_comments.where(comment_id: comment.id).exists?
  end

  def create_pfav(post)
    FavPost.create!(user_id: id, post_id: post.id)
  end
  def create_cfav(comment)
    FavComment.create!(user_id: id, comment_id: comment.id)
  end

  def del_pfav(post)
    self.fav_posts.find_by(post_id: post.id).destroy
  end

  def del_cfav(comment)
    self.fav_comments.find_by(comment_id: comment.id).destroy
  end
end

