# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :posts, dependent: :destroy

  def followed?(person)
    Follow.where(follower: self,followed: person).present?
  end

  #userをfollowしているか
  def follow?(person)
    Follow.where(follower: person,followed: self).present?
  end
end
