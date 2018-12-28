# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :email, uniqueness: true
  #validates :password, presence: true
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :fav_posts, dependent: :destroy
  has_many :fav_comments, dependent: :destroy
  # 1:多 でloginuserがfollowする場合
  has_many :active_relationships, class_name: "Follow", foreign_key: "follower_user_id", dependent: :destroy
  # #多:1 でloginuserがfollowされる場合
  has_many :passive_relationships, class_name: "Follow", foreign_key: "followed_user_id", dependent: :destroy
  # #loginuserがfollowしているuser集団取得
  has_many :followeds, through: :active_relationships, source: :followed_user
  # #loginuserをfollowしているuser集団取得
  has_many :followers, through: :passive_relationships, source: :follower_user
  # has_many :follow, dependent: :destroy
  has_one :profile

  # loginuser -> another
  def follow?(user)
    active_relationships.find_by(followed_user_id: user).present?
  end

  # another ->loginuser
  def followed?(user)
    passive_relationships.find_by(follower_user_id: user).present?
  end

  # loginuser -> another
  def create_follow(user_id)
    # Follow.create!(follower_user_id: id,followed_user_id: user_id)
    active_relationships.create!(followed_user_id: user_id)
  end

  # loginuser -> another
  def del_follow(user_id)
    # Follow.where(follower_user_id: user_id,followed_user_id: id).destroy
    active_relationships.find_by(followed_user_id: user_id).destroy
  end

  def find_pfav?(post)
    fav_posts.where(post_id: post.id).exists?
  end

  def find_cfav?(comment)
    fav_comments.where(comment_id: comment.id).exists?
  end

  def create_pfav(post)
    FavPost.create!(user_id: id, post_id: post.id)
  end

  def create_cfav(comment)
    FavComment.create!(user_id: id, comment_id: comment.id)
  end

  def del_pfav(post)
    fav_posts.find_by(post_id: post.id).destroy
  end

  def del_cfav(comment)
    fav_comments.find_by(comment_id: comment.id).destroy
  end

  def follower_posts #followers_posts
    return posts.where(user_id: followeds.pluck(:id).push(id), trans: [1, 3])
  end

  "" "def get_posts(user)
    posts = login_user.posts #まずは自分の投稿取得
    if login_user.follow?(user) #他人の投稿のうちfollowerのみのもの
      post.push(user.posts.where(trans: [1, 3]))
    else
      posts.push(user.posts.where(trans: [1]))
    end
    return posts
  end" ""

  def niltest(name)
    raise "name is nil." if name.nil?

    @items << item
  end
end
