class HomeController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    skip_before_action  :authenticate_user!, only: :index
  
    # GET /posts
    # GET /posts.json
    def index
      @posts = Post.all
    end
  
    # GET /posts/1
    # GET /posts/1.json
    #def show
    #end

    def mypage
      @mypost = Post.where(user_id: current_user.id)
    end
end
  