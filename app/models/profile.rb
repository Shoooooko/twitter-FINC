# frozen_string_literal: true

class Profile < ApplicationRecord
  mount_uploader :picture, PictureUploader
end
