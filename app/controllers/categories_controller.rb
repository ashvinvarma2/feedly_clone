class CategoriesController < ApplicationController
  def index; end

  def create
    @category = Category.new(category_params)

    if @category.save
      respond_to do |format|
        format.turbo_stream
        format.html { render json: { category: @category }, status: :created }
      end

    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
    rss_feed_ids = @category.rss_feed_ids.any? ? @category.rss_feed_ids : [0]
    board_ids = current_user.board_ids.any? ? current_user.board_ids : [0]
    result = Article.select("articles.*,
                             bool_or(user_articles.marked_as_read) as marked_as_read,
                             bool_or(user_articles.read_later) as read_later,
                             array_agg(board_articles.board_id) as b_ids")
                    .joins("LEFT JOIN board_articles ON articles.id = board_articles.article_id AND board_articles.board_id IN (#{board_ids.join(',')})")
                    .joins("LEFT JOIN user_articles ON articles.id = user_articles.article_id AND user_articles.user_id = #{current_user.id}")
                    .where("articles.rss_feed_id IN (#{rss_feed_ids.join(',')})")
                    .group("articles.id")
                    .order("articles.pub_date DESC")

    render_feeds(@category.name, result)
  end

  private

  def category_params
    params.require(:category).permit(:name, :user_id)
  end
end
