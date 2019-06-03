class MyThreads::CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :edit, :update, :destroy]
    #GET /comments
    def index
        @comments= Comment.where(my_thread_id: params[:my_thread_id])
        @my_thread = MyThread.find(params[:my_thread_id])
        @user=current_user.name
    end

    #GET /comments/1
    def show
    end

    #GET /comments/new
    def new
        @comment = Comment.new
        @comment.user_id = current_user.id
        @my_thread = MyThread.find(params[:my_thread_id])
        @comment.my_thread_id = @my_thread.id
    end

    #GET /comments/edit
    def edit
        @my_thread=MyThread.find(params[:my_thread_id])
        @comment.my_thread_id = params[:my_thread_id]
    end

    #POST /comments
    def create
        @comment = Comment.new(comment_params)
        @comment.my_thread_id = params[:my_thread_id]
        @comment.user_id = current_user.id
        if @comment.save
            redirect_to my_thread_comments_url, notice: 'My comment was successfully created.'
        else
            render :show
        end
    end

    # PATCH/PUT /comments/1
    def update
        if @comment.update(comment_params)
            render :show, status: :updated, location: @comment
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
            #@my_thread=MyThread.find(params[:my_thread_id])
        end

        def comment_params
            params.require(:comment).permit(:id,:title,:body,:user_id,:my_thread_id )
        end
end
