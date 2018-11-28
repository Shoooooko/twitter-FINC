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
  #1:多 でloginuserがfollowする場合
  has_many :active_relationships,class_name: "Follow", foreign_key: "follower", dependent: :destroy
  # #多:1 でloginuserがfollowされる場合
  has_many :passive_relationships,class_name: "Follow", foreign_key: "followed", dependent: :destroy
  # #loginuserがfollowしているuser集団取得
  has_many :followeds, through: :active_relationships, source: "followed"
  # #loginuserをfollowしているuser集団取得
  has_many :followers, through: :passive_relationships, source: "follower"
  #has_many :follow, dependent: :destroy
  has_one :profile

  #loginuser -> another
  def follow?(user)
    self.active_relationships.include?(user)
  end
  #another ->loginuser
  def followed?(user)
    self.passive_relationships.include?(user)
  end
  #loginuser -> another
  def create_follow(user)
    binding.pry
    Follow.create!(follower: id,followed: user)
  end
  
  #loginuser -> another
  def del_follow(user)
    Follow.where(follower: user,followed: id).destroy
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

