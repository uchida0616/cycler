class ArticlesController < ApplicationController
  def index
    @articles = Article.all.where.not(picture: nil)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create(article_params)
    if params[:back]
      render :new
    else
      if @article.save
        redirect_to articles_path, notice: "投稿しました！"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path, notice: "投稿を編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to posts_path, notice:"投稿を削除しました！"
  end

  def confirm
    @article = Article.new(article_params)
    render :new if @article.invalid?
  end

  def article_params
    params.require(:article).permit(:description, :picture, :image_cache)
  end
end
