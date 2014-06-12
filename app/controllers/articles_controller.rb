class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def index
  	@articles = Article.all
  end

  def show  	
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
  	@article = Article.new
  end

  def create
  	@article = Article.new(article_params)
  	if @article.save
  		flash[:notice] = "Article created!"
  		redirect_to article_path(@article)
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
  	@article.update(article_params)
  	flash[:notice] = "Article Updated!"
  	redirect_to article_path(@article)
  end

  def destroy
  	@article.destroy
  	flash[:notice] = "Article Deleted!"
  	redirect_to articles_path
  end

  private
  
  def set_article
  	@article = Article.find(params[:id])
  end

  def article_params
  	params.require(:article).permit(:title, :body, :tag_list)
  end
end
