class ArticlesController < ApplicationController

  skip_before_action :authenticate_user!, only: %i[show index]
  before_action :set_article, only: %i[edit update show destroy]

  # This is the new action that creates a variable in our controller
  def new
    @article = Article.new
  end

  def index
    @articles = Article.all
  end

  def create
    @article = Article.new(article_params)
    
    if @article.save
      flash[:notice] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      flash[:alert] = 'Article was not updated'
      render 'new'
    end
  end

  def show
    session[:article_id] = @article.id
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article was updated'
      redirect_to article_path(@article)
    else
      flash[:alert] = 'Article was not updated'
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = 'Article was deleted'
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
