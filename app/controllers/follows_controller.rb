class FollowsController < ApplicationController
    #homeにindexのaction移行
    def index
        #自分をfollowしているfollower一覧
        @follower_ids=Follow.where(followed: current_user.id)
        @follower_ids.each do |f|
            @followers = User.where(user_id: f)
        end
    end

    def show
        @f_posts = Post.where(user_id: params[:follower].follower)
        @follower = User.find(params[:follower].follower)
    end
    # GET /follows/new
    #def new
       # @follow = Follow.new
    #end

    def create
        @follow = Follow.new(follow_params)
        @follow.follower = current_user.id
        @follow.followed = params[:followed]
        if @follow.save
            format.html { redirect_to @follow, notice: 'follow was successfully created.' }
            format.json { render :index, status: :created, location: @follow }
        else
            format.html { render :index }
            format.json { render json: @follow.errors, status: :unprocessable_entity }
        end
        end
  end

  def destroy
    @follow.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  Private
    #def set_follow
        #@follow = Follow.find(params[:followed])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    def follow_params
        params.require(:follow).permit(:follower, :followed)
    end



end
