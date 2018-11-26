class FollowsController < Users::BaseController
  def create
    @follow = @user.create_follow(follow_params[:followed])
    redirect_to users_path, notice: 'follow was successfully created.'
  end

  def destroy
    if @user.follow?(follow_params[:followed])
      @user.del_follow(follow_params[:followed])
      redirect_to users_path, notice: 'follow was successfully destroyed.'
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def follow_params
    params.permit(:followed)
  end
end
