class Image < ApplicationRecord
  belongs_to :posts
  mount_uploader :picture, PictureUploader
  #validate :limit_image # 保存時に limit_image によりバリデーションをする
  # バリデーションメソッド
  # def limit_image(post)
  #   if Image.where(post_id: post).count >2
  #     errors.add("登録可能な写真は3枚までです。") # エラーメッセージ
  #   end
  # end
end
