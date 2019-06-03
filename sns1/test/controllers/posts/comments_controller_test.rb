# frozen_string_literal: true

require "test_helper"

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get body:text" do
    get posts_comments_body: text_url
    assert_response :success
  end

  test "should get references:users" do
    get posts_comments_references: users_url
    assert_response :success
  end

  test "should get references:posts" do
    get posts_comments_references: posts_url
    assert_response :success
  end
end
