class FavPostController < ApplicationController
    before_action :exist_post, only: [:create]
    before_action :set_post, only: [:exist_post]

    def create
        if @favcount==0
            @fav = Fav_post.new
            @fav.user_id = current_user.id
            @fav.post_id =params[:id]
            if @fav.save
                redirect_to post_path, notice: 'いいねしました！'
            else
                redirect_to post_path
        else
            flash[:notice] = "すでにいいねしています"
            redirect_to post_post_path(@favcount)
        end
    end

    end
    private
        def exist_post
            @favs=Fav_post.where(post_id: params[:id])
            @favcount=@favs.count
        end

        def set_post
            params.permit(:id,:title, :body,:user_id)
        end
end