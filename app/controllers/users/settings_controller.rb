class Users::SettingsController < ApplicationController
    before_action :set_setting, only: [:show, :edit,:destroy]
    before_action :setting_params, only: [:create,:update]


    def new
        @setting = Setting.new
    end

    def edit
    end

    def create
        @setting = Setting.new(setting_params)
        @setting.user_id=current_user.id
            if @setting.save
                redirect_to home_mypage_path, notice: 'setting was successfully created.'
            else
                render :new
            end
            #format.html { redirect_to 'home_mypage_path', notice: 'setting was successfully created.' }
            #format.json { render :show, status: :created, location: @setting }
            #else
            #format.html { render :new }
            #format.json { render json: @setting.errors, status: :unprocessable_entity }
            #end
    end
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
        @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
        params.permit(:public_degree,:user_id)
        #params.require(:setting).permit(:public_degree,:user_id)
    end
end
