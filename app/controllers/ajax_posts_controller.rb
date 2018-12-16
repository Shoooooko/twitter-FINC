class AjaxPostsController < Users::BaseController
  protect_from_forgery except: :create 
  def create
      #binding.pry
      #@post = Post.create!(body: post_params, user_id: current_user.id)
      @post = current_user.posts.create!(body: post_params[:body], trans: 1)
      render json: @post
  end
  private
    def post_params
      params.permit(:body)
    end
end
