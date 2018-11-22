class UsersController < Users::BaseController
    def index
        @follows =[]#others login user follows
        @nonfollows =[]#others login user o not follows
        @users = User.all
        @users.each do |user|
            if user != current_user
                if current_user.follow?(user)
                    @follows.push(user)
                else
                    @nonfollows.push(user)
                end
            end
        end
    end
end
