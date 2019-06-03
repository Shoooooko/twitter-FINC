# frozen_string_literal: true

class FollowsController < Users::BaseController
  def create
    @follow = @user.create_follow(follow_params[:followed_user_id])

    redirect_to user_path(id: follow_params[:followed_user_id]),
    notice: "follow was successfully created."
  end

  def destroy
    if @user.follow?(follow_params[:followed_user_id])
      @user.del_follow(follow_params[:followed_user_id])
      redirect_to user_path(id: follow_params[:followed_user_id]),
      notice: "follow was successfully destroyed."
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def follow_params
    params.permit(:followed_user_id)
  end
end
