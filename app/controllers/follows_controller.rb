# frozen_string_literal: true

class FollowsController < Users::BaseController
  def create
    @follow = Follow.create!(follower: @user.id, followed: follow_params[:followed])
    redirect_to users_path, notice: 'follow was successfully created.'
  end

  def destroy
    @follow = Follow.find_by(follower: current_user.id, followed: follow_params[:followed])
    if @follow.destroy
      flash[:notice] = 'follow was successfully destroyed.'
      redirect_to users_path
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def follow_params
    params.permit(:followed)
  end
end
