class MyThreadsController < ApplicationController
    before_action :set_my_thread, only: [:show, :edit, :update, :destroy]
    #GET /my_threads
    def index
        @my_threads = MyThread.all
        @user=current_user.name
    end

    #GET /my_threads/1
    def show
    end

    #GET /my_threads/new
    def new
        @my_thread = MyThread.new
        @my_thread.user_id = current_user.id
    end

    #GET /my_threads/edit
    def edit
    end

    #POST /my_threads
    def create
        @my_thread = MyThread.new(my_thread_params)
        @my_thread.user_id = current_user.id
        if @my_thread.save
            redirect_to @my_thread, notice: 'My thread was successfully created.'
        else
            render :show
        end
    end

    # PATCH/PUT /my_threads/1
    def update
        if @my_thread.update(my_thread_params)
            render :show, status: :updated, location: @my_thread
        else
            render :edit
        end
    end

    # DELETE /my_threads/1
    def destroy
        @my_thread.destroy
        redirect_to my_threads_url, notice: '投稿が削除されました'
    end

    private
        def set_my_thread
            @my_thread = MyThread.find(params[:id])
        end

        def my_thread_params
            params.require(:my_thread).permit(:title,:body,:user_id)
        end
    
end
