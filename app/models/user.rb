# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :posts, dependent: :destroy

  def follow?(user)
    Follow.where(follower: self,followed: user).present?
  end

  #userをfollowしているか
  def followed?(user)
    Follow.where(follower: user,followed: self).present?
  end
end