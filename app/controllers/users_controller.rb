class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(params.require(:user).permit(:name, :email, :password))
        @user.save
        redirect_to :root
    end

    def edit
    end

    def update
    end
end
