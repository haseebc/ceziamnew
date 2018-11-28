class CommentsController < ApplicationController

  skip_before_action :authenticate_user!, only: %i[show index]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user = current_user
    
    if @comment.save
      redirect_to article_path(@article)
    else
      flash[:alert] = 'Comment was not created'
      redirect_to article_path(@article)
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
