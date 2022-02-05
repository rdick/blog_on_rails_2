class UsersController < ApplicationController
    def show
    end
    
    def new
        if user_signed_in?
            flash[:danger] = "Already Signed In: Can Not Make A New Account"
            redirect_to posts_path 
        end
        @user = User.new
    end

    def create
        @user = User.new(params.require(:user).permit(:name, :email, :password))
        @user.save
        redirect_to new_session_path
    end

    def edit
    end

    def update
        user = User.find current_user.id
        passwordParams = params.require(:user).permit(:password,:newpassword,:newpassword_confirmation)
        emailNameParams = params.require(:user).permit(:name,:email)

        if passwordParams.empty?
            if (user.update(emailNameParams))
                flash[:success] ="username and email changed"
                redirect_to user_path(:user)
            else
                flash[:danger] ="user parameters incorrect"
                redirect_to user_path(:user)
            end
        end

        if emailNameParams.empty?
            if ((passwordParams[:newpassword] == passwordParams[:newpassword_confirmation]) && 
                (passwordParams[:password] != passwordParams[:newpassword]) && 
                (user.authenticate(passwordParams[:password])))
                if user.update_attribute(:password, passwordParams[:newpassword])
                    flash[:success] = "Password Changed"
                    redirect_to user_path(:user)
                else
                    flash[:danger] ="User Parameters Incorrect"
                    redirect_to user_path(:user)
                end
            else
                flash[:danger] ="User Parameters Incorrect"
                redirect_to user_path(:user)
            end
        end 
    end
end
