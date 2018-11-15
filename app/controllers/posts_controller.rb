# frozen_string_literal: true

class PostsController < Users::BaseController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :post_params, only: %i[create update]
  before_action :set_images,only: %i[show edit update destroy]
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
      @post = Post.create!(title: post_params[:title],body: post_params[:body],
      trans: post_params[:trans],user_id: current_user.id )
      @images=post_params[:picture]
      if @images.any?
        @images.each do |image|
          #binding.pry
          Image.create!(post_id: @post.id, picture: image)
          # Image.create!(post_id: @post.id,
          #    picture: open ("#{Rails.root}/path/to/#{image.original_filename}"))
        end
      end
      @images =Image.where(post_id: @post.id)
    end
      redirect_to posts_path, notice: 'Post was successfully created.'
    rescue =>e
      redirect_to new_post_path, notice: 'Post was not be created.'
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    Post.transaction do
      @post = Post.update!(title: post_params[:title],body: post_params[:body],
        trans: post_params[:trans],user_id: current_user.id )
      @images.each do |image|
        Image.update!(picture: image,post_id: @post.id)
      end
      @images = Image.where(post_id: @post.id)
    end
      redirect_to post_path(params[:id]), notice: 'Post was successfully updated.'
    rescue =>e
      redirect_to edit_post_path(params[:id]), notice: 'Post was not be updated.'
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy #imageも消える
      redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find_by(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:id, :title, :body,:trans,:user_id,
      {picture:[]},:picture_cache)
  end
  def set_images
    @images = Image.where(post_id: params[:id])
  end
end
