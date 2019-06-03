class Api::PostsController < Users::BaseController
  protect_from_forgery with: :null_session

  def create
    post = @user.posts.create!(body: post_params[:body], trans: post_params[:trans])
    render json: { id: post.id, body: post.body }
  end

  private

  def post_params
    params.permit(:body,:trans)
  end
end
