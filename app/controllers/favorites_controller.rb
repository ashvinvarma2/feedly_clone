class FavoritesController < ApplicationController
  before_action :set_favoritable, only: [:handle_favorite]

  def handle_favorite
    @favorite = current_user.favorites.find_or_initialize_by(favoritable: @favoritable)
    if @favorite.persisted?
      @favorite.destroy
    else
      @favorite.save
    end

    turbo_stream
  end

  private

  def set_favoritable
    case params[:favoritable_type]
    when "Board"
      @favoritable = Board.find(params[:favoritable_id])
    when "RssFeed"
      @favoritable = RssFeed.find(params[:favoritable_id])
    when "Category"
      @favoritable = Category.find(params[:favoritable_id])
    end
  end
end
