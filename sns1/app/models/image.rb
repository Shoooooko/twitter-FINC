# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :posts, optional: true # transactionでreference先を検査しない
  mount_uploader :image, PictureUploader
end
