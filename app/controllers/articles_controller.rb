class ArticlesController < ApplicationController

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
        @article = Article.find(params[:id])
    end

private
    def article_params
        params.require(:article).permit(:title, :description)
    end

end