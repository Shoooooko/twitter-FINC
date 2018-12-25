class Api::PostsController < Users::BaseController
  protect_from_forgery except: :create 
  def create
      @post = current_user.posts.create!(body: post_params[:body], trans: 1)
      #render json: { id: @post.id, body: @post.body }.to_json
      render json: @post
  end
  private
    def post_params
      params.permit(:body)
    end
end
