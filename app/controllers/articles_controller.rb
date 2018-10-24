class ArticlesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:show, :index]
    before_action :set_article, only: [:edit, :update, :show, :destroy]

    # This is the new action that creates a variable in our controller
    def new
        @article = Article.new
    end

    # This is the create action to create an article
    # def create
    #     render plain: params[:article].inspect
    # end

    # def create
    #     @article = Article.new(article_params)
    # #saving article to the database
    #     @article.save
    #     redirect_to articles_show(@article)
    # end

    def index
        @articles = Article.all
    end

    def create
        @article = Article.new(article_params)
        if @article.save
         flash[:notice] = "Article was successfully created"
         redirect_to article_path(@article)
        else
         render 'new'
        end
    end

    def show
        # @article = Article.find(params[:id])
    end

    def edit
        # @article = Article.find(params[:id])
    end 

    def update
        # @article = Article.find(params[:id])
        if @article.update(article_params)
         flash[:notice] = "Article was updated"
         redirect_to article_path(@article)
        else
         flash[:notice] = "Article was not updated"
         render 'edit'
        end
    end

    def destroy
        # @article = Article.find(params[:id])
        @article.destroy
        flash[:notice] = "Article was deleted"
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