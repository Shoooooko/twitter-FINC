class Posts::FavCommentController < ApplicationController
    before_action :set_comment, only: [:exist_comment]
    before_action :exist_comment, only: [:create]
    
    def create
        if @favcount==0
            @fav = Fav_comment.new
            @fav.user_id = current_user.id
            @fav.comment_id =params[:id]
            if @fav.save
                redirect_to post_comment_path, notice: 'いいねしました！'
            else
                redirect_to post_comment_path
        else
            flash[:notice] = "すでにいいねしています"
            redirect_to post_post_comment_path(@favcount)
        end
    end

    end
    private
        def exist_comment
            @favs=Fav_comment.where(comment_id: params[:id])
            @favcount=@favs.count
        end

        def set_comment
            params.permit(:id,:body,:user_id,:post_id)
        end
end