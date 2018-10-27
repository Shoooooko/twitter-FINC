class Profile < ApplicationRecord
    mount_uploader :picture, PictureUploader
end
