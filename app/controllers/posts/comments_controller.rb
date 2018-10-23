class Posts::CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :edit, :update, :destroy]
    before_action :set_post, only: [:index, :new, :edit, :destroy]
    #GET /comments
    def index
        @comments= Comment.where(post_id: params[:post_id])
    end

    #GET /comments/1
    def show
    end

    #GET /comments/new
    def new
        @comment = Comment.new
        @comment.user_id = current_user.id
        @comment.post_id = @post.id
    end

    #GET /comments/edit
    def edit
        @comment.post_id = params[:post_id]
    end

    #POST /comments
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            redirect_to post_comments_url, notice: 'My comment was successfully created.'
        else
            render :show
        end
    end

    # PATCH/PUT /comments/1
    def update
        if @comment.update(comment_params)
            render :show
        else
            render :edit
        end
    end

    # DELETE /comments/1
    def destroy
        @comment.destroy
        redirect_to comments_url, notice: 'コメントが削除されました'
    end

    private
        def set_comment
            @comment = Comment.find(params[:id])
        end

        def set_post
            @post=Post.find(params[:post_id])
        end

        def comment_params
            params.require(:comment).permit(:id,:body,:user_id,:post_id )
        end
end

