class Users::ResorcesController < Devise::ResorcesController

    # GET /users/1
    before_action :set_user, only: [:mypage]
    def mypage
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:resource])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end