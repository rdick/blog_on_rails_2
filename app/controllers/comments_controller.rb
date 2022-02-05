class CommentsController < ApplicationController
    def create
        @comment = Comment.new(params.require(:comment).permit(:body))
        
        @post = Post.find params[:post_id]
        @comment.post = @post
        @comment.user = current_user
        @comment.save

        redirect_to @post
    end

    def destroy
        @comment = Comment.find params[:id]
        @post = @comment.post
        if can? :crud, @comment
            @comment.destroy
            redirect_to @post
        else
            flash[:danger] = "Cannot Delete Other Peoples Comments"
            redirect_to @post
        end
    end
end
