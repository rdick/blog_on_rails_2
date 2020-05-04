class CommentsController < ApplicationController
    def create
        @comment = Comment.new(params.require(:comment).permit(:body))

        
        @post = Post.find params[:post_id]
        @comment.post = @post
        @comment.save

        redirect_to @post
    end

    def destroy
        @comment = Comment.find params[:id]
        @post = @comment.post
        @comment.destroy

        redirect_to @post
    end
end
