class MyThread < ApplicationRecord
  belongs_to :user
  validates :body,  {presence: true, length: {maximum: 200}}
  validates :title,presence: true
  has_many :comments, dependent: :destroy
end
