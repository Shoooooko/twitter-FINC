# frozen_string_literal: true

class FollowsController < Users::BaseController
  #before_action :check_follow, only: %i[show destroy]
  before_action :follow_params, only: :create
  
  def create
    @follow = Follow.create(follower: current_user.id, followed: params[:followed])
      redirect_to users_path, notice: 'follow was successfully created.'
  end

  def destroy
    @follow = Follow.find_by(follower: current_user.id, followed: params[:followed])
    if @follow.destroy
      flash[:notice] = 'follow was successfully destroyed.'
      redirect_to users_path
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def follow_params
    params.permit(:follower, :followed)
  end
end
