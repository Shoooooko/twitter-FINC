# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  # 姓、名、メール、パスワードがあれば有効な状態であること
  it "is valid with a name, email, and password" do
    user = User.new(
      name: "Shokoko",
      email: "Shoko@gmail.com",
      password: "shokoko",
    )
    expect(user).to be_valid
  end
  # 名がなければ無効な状態
  it "is invalid without a name" do
    expect(User.new(name: nil)).not_to be_valid
  end

  # パスワードがなければ無効な状態であること
  it "is invalid without a encrypted_password" do
    expect(User.new(password: nil)).not_to be_valid
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    expect(User.new(email: nil)).not_to be_valid
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address"

  # ユーザーのフルネームを文字列として返すこと
  it "returns a user's full name as a string"

  # pending "add some examples to (or delete) #{__FILE__}"
  # it "登録できること" do
  #   user = User.new(name: 'パトラッシュ',
  #                   email: 'patorash@email.com',
  #                   password: 'password',
  #                   password_confirmation: 'password')
  #   expect(user.save).to be_true
  # end
end
