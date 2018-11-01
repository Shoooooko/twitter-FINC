class UsersController < ApplicationController
    def index
        @friend = []#follow at each other
        @followed =[]#only followed by the login user
        @nonfollowed = []#only follow the login user
        @stranger = [] #not follow at each other
        @users = User.all
        @users.each do |person|
            if person!=current_user
        #personがloginuserにfollowされているか
                if current_user.followed?(person)
                    #personがloginuserをfollowしているか
                    if current_user.follow?(person)
                        @friend.push(person)
                    else
                        @followed.push(person)
                    end
                elsif
                    if current_user.follow?(person)
                        @nonfollowed.push(person)
                    else
                        @stranger.push(person)
                    end
                end
            end
        end
    end
      #userをfollowしている人のみ詳細がみれる @friends,@nonfollowed
    def show
        @follower = User.find_by(id: params[:id])
        @f_posts = Post.where(user_id: params[:id])
    end
end
