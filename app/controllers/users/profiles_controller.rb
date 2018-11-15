# frozen_string_literal: true

class Users::ProfilesController < Users::BaseController
  before_action :set_profile, only: %i[show edit update destroy]
  # new画面で入力してcreateメソッドに飛ばす
  # GET /profiles/new
  def new
    @profile = Profile.new
    @profile.user_id = current_user.id
  end

  # create後showに登録profile表示
  # GET /profiles
  # GET /profiles/1
  def show; end

  # GET /profiles/edit
  def edit; end

  # user /profiles
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    @user = current_user
    if @profile.save
      redirect_to user_profile_path(@user, @profile), notice: 'My profile was successfully created.'
    else
      render :show
    end
  end

  # PATCH/PUT /profiles/1
  def update
    if @profile.update(profile_params)
      render :show
    else
      render :edit
    end
  end

  # DELETE /profiles/1
  def destroy
    @profile.destroy
    redirect_to profiles_url, notice: 'コメントが削除されました'
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.permit(:user_id, :picture, :nickname)
  end
end
