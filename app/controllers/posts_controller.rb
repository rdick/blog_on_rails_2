class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create,:show, :destroy, :edit, :update]
    before_action :authorize!, only: [:destroy, :edit]

    def index
        @posts = Post.all
    end

    def show
        @post= Post.find params[:id]
        @comment = Comment.new

        @comments =  @post.comments
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(params.require(:post).permit(:title,:body))
        @post.user = current_user
        if @post.save
            redirect_to :root
        else 
            flash[:danger] ="Incorrect Parameters"
            redirect_to new_post_path
        end
    end

    def edit
        @post = Post.find params[:id]
    end

    def update
        @post = Post.find params[:id]
        @post.update(params.require(:post).permit(:body,:title))
        if @post.save
            redirect_to @post
        else 
            flash[:danger] ="Incorrect Parameters"
            redirect_to edit_post_path
        end
    end

    def destroy
        @post = Post.find params[:id]
        @post.destroy
        redirect_to :root
    end

    private

    def authorize! 
        @post = Post.find params[:id]
        if !can?(:crud, @post)
            flash[:danger] = 'Acess Denied'
            redirect_to :root
        end
    end
end
