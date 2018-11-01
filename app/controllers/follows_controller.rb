# frozen_string_literal: true

class FollowsController < ApplicationController
  #before_action :check_follow, only: %i[show destroy]
  before_action :follow_params, only: :create
  # homeにindexのaction移行

  def index
    # 自分をfollowしているfollower一覧
    @followed =[]
    @nonfollowed = []
    @users = User.all
    @users.each do |person|
      if User.followed?(person)
        @followed.push(User.find_by(id: person))
      else
        @nonfollowed.push(User.find_by(id: person))
      end
    end
  end

  #userをfollowしている人のみ詳細がみれる
  def show
    @follower = User.find_by(id: params[:id])
    if User.follow?(@follower)
      @f_posts = Post.where(user_id: params[:id])
    else
      flash[:notice]= 'followされていないuserの情報をみることはできません。'
      redirect_to follows_path
    end
  end

  def create
    @follow = Follow.create(follower: current_user.id, followed: params[:followed])
    respond_to do |format|
      format.html { redirect_to follows_path, notice: 'follow was successfully created.' }
      format.json { render :index, status: :created, location: @follow }
    end
  end

  def destroy
    @follow = Follow.find_by(follower: current_user.id, followed: params[:followed])
    if @follow.destroy
      flash[:notice] = 'follow was successfully destroyed.'
      respond_to do |format|
        format.html { redirect_to follows_path }
        format.json { head :no_content }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def follow_params
    params.permit(:follower, :followed)
  end
end
