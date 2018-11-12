# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_params, only: %i[create update destroy]
  before_action :set_images, only:%i[show edit update destroy]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = User.where(id: @post.user_id)
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
      @post = Post.new(post_params)
      @post.save!
      if @pics !=nil
        @pics.each do |image|
          Image.create(image)
        @images =Image.where(post_id: params[:id])
        end
      end
    end
      redirect_to posts_path, notice: 'Post was successfully created.' }
    rescue =>e
      redirect_to new_post_path, notice: 'Post was not be created.' }
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    Post.transaction do 
      @post = Post.update(post_params)
      @pics.each do |image|
        Image.update(image)
      @images = Image.where(post_id: params[:id])
      end
    end
      redirect_to post_path(@post.id), notice: 'Post was successfully updated.' }
    rescue =>e
      redirect_to edit_post_path(@post.id), notice: 'Post was not be updated.' }
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy #imageも消える
      redirect_to posts_url, notice: 'Post was successfully destroyed.' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:id, :title, :body, :trans, :user_id)
    #params.require(:image).permit({picture: []})
  end
  def set_images
    @pics = Image.where(post_id: params[:id])
  end
end
