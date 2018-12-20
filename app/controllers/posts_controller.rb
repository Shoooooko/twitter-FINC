# frozen_string_literal: true

class PostsController < Users::BaseController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :post_params, only: %i[create update]
  before_action :set_images, only: %i[show edit update destroy]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @postuser = User.find_by(id: @post.user_id)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  # POST /posts.json
  def create
    Post.transaction do
      @post = Post.create!(title: post_params[:title], body: post_params[:body],
                           trans: post_params[:trans], user_id: current_user.id)
      if @post.images_limit?
        @images = post_params[:image]
        if @images.present?
          @images.each do |image|
            Image.create!(post_id: @post.id, image: image)
          end
        end
      else
        redirect_to new_post_path, notice: "登録可能な写真は3枚までです。"
      end
    end
    redirect_to posts_path, notice: "Post was successfully created."
  rescue StandardError => e
    redirect_to new_post_path, notice: "Post was not be created."
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @user.id == @post.id
      begin
        Post.transaction do
          if @user.id == @post.id
            @post = Post.update!(title: post_params[:title], body: post_params[:body],
                                 trans: post_params[:trans], user_id: current_user.id)
            @images.each do |image|
              Image.update!(image: image, post_id: @post.id)
            end
          end
        end
        redirect_to post_path(params[:id]), notice: "投稿が更新されました。"
      rescue StandardError => e
        redirect_to edit_post_path(params[:id]), notice: "投稿が更新できませんでした。"
      end
    else
      redirect_to posts_path, notice: "他人の投稿を編集することはできません。"
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy # imageも消える
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find_by(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:id, :title, :body, :trans, :user_id,
                                 {image: []}, :image_cache)
  end

  def set_images
    @images = Image.where(post_id: params[:id])
  end
end
