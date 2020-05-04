class PostsController < ApplicationController
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
        @post = Post.new(params.require(:post).permit(:body,:title))
        @post.save

        redirect_to :root
    end

    def edit
        @post = Post.find params[:id]
    end

    def update
        @post = Post.find params[:id]
        @post.update(params.require(:post).permit(:body,:title))
        @post.save

        redirect_to @post
    end

    def destroy
        @post = Post.find params[:id]
        @post.destroy
        redirect_to :root
    end
end
