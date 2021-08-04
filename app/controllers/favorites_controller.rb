class FavoritesController < ApplicationController
  def index
  @favorites = Favorite.all
end
  def create
    favorite = current_user.favorites.create(article_id: params[:article_id])
    redirect_to articles_url, notice: "#{favorite.article.user.name}さんのブログをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to articles_url, notice: "#{favorite.article.user.name}さんのブログのお気に入りを解除しました"
  end
end
