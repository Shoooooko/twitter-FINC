# frozen_string_literal: true

class PostsController < Users::BaseController
  before_action :set_post, only: %i[show edit update destroy]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    #@posts = Post.all.order('created_at ASC')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @images = @post.images
    @postuser = User.find_by(id: @post.user_id)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    #@images = Image.where(post_id: params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    begin
      Post.transaction do
        @post = Post.create!(title: post_params[:title], body: post_params[:body],
                             trans: post_params[:trans], user_id: current_user.id)
        @images = post_params[:image]
        if @images.present?
          create_img(@images)
          if @post.images_limit? #imagesが3より多いとtrue
            redirect_to new_post_path, notice: "登録可能な写真は3枚までです。"
          end
        end
        redirect_to posts_path, notice: "Post was successfully created."
      end
    rescue StandardError => e
      redirect_to new_post_path, notice: "Post was not be created."
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    begin
      #@images = Image.where(post_id: post_params[:id])
      Post.transaction do
        @post = Post.find_by(id: params[:id], user_id: current_user.id)
        #if @user.id == @post.user_id
        @post.update!(title: post_params[:title], body: post_params[:body],
                      trans: post_params[:trans], user_id: current_user.id)
        @post.del_img(@post.images) #一旦保存されてる画像レコード消去
        @images = post_params[:image]
        @post.create_img(@images)
        if @post.images_limit? #imagesが3より多いとtrue
          redirect_to new_post_path, notice: "登録可能な写真は3枚までです。"
        else
          redirect_to post_path(params[:id]), notice: "投稿が更新されました。"
        end
      end
    rescue StandardError => e
      redirect_to edit_post_path(params[:id]), notice: "投稿が更新できませんでした。"
    end
  end

  "" "i=0
        @images.each do |image|
          image.update!(image: post_params[:image][i], post_id: @post.id)
          i+=1
        end" ""
  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    #@images = Image.where(post_id: params[:id])
    @post.destroy # imageも消える
    redirect_to homes_mypage_path, notice: "Post was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post  #paramのpost_idとuser_idの一致のチェック
    @post = Post.find_by(id: params[:id], user_id: current_user.id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:id, :title, :body, :trans, :user_id,
                                 {image: []}, :image_cache)
  end
end
