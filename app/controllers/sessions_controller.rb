class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user&.authenticate params[:password]
            session[:user_id] = @user.id
            session[:color] = 'blue' 
            flash[:success] = "User Logged In"

            redirect_to posts_path
        else
            flash[:warning] = "Couldn't log In"
            redirect_to new_session_path
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to new_session_path
    end
end
