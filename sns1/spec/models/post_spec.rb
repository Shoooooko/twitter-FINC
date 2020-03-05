require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = User.create(
      name: "Shokoko",
      email: "Shoko@gmail.com",
      password: "shokoko")
    @other = User.create(
      name: "doraemon",
      email: "doradora@gmail.com",
      password: "dorako")
  end
  # 姓、名、メール、パスワードがあれば有効な状態であること
  it "is valid with user_id, body, and title" do
    post = Post.new(
      user_id: @user.id,
      title: "testpost",
      body: "test_message")
    expect(post).to be_valid
  end

  #user_idがなければ無効な状態
  it "is invalid without user_id" do
    #expect(User.new(name: nil)).not_to be_valid
    expect(Post.new(user_id: nil)).not_to be_valid
  end

  # タイトルがなければ無効な状態であること
  it "is invalid without title" do
    #expect(User.new(password: nil)).not_to be_valid
    post = Post.new(title: nil)
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  # 本文bodyがなければ無効な状態であること
  it "is invalid without the body" do
    expect(Post.new(body: nil)).not_to be_valid
  end

  # # 200字以上本文が超えると有効な状態であること
  # it it "is invalid with over letters" do
  #   post = Post.new(body:"さかな"*30)
  #   post.valid?
  #   expect(post.errors[:body]).to include("too many letters")
  # end
end
