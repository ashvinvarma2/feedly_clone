class BoardsController < ApplicationController
  def index; end

  def create
    @board = current_user.boards.create(boards_params)
    turbo_stream
  end

  def show
    @board = Board.find(params[:id])
    result = Article.select("articles.*,
                             bool_or(user_articles.marked_as_read) as marked_as_read,
                             bool_or(user_articles.read_later) as read_later,
                             array_agg(board_articles.board_id) as b_ids")
                    .joins("LEFT JOIN board_articles ON articles.id = board_articles.article_id AND board_articles.board_id = #{@board.id}")
                    .joins("LEFT JOIN user_articles ON articles.id = user_articles.article_id AND user_articles.user_id = #{current_user.id}")
                    .where("board_articles.board_id = #{@board.id}")
                    .group("articles.id")
                    .order("articles.pub_date DESC")

    render_feeds(@board.title, result)
  end

  def save_feed_to_board
    @article = Article.find(params[:article_id])
    board = Board.find(params[:board_id])
    board.articles << @article

    @article = @article.setup_article_for_feed(current_user)

    turbo_stream
  end

  def remove_feed_from_board
    @article = Article.find(params[:article_id])
    board = Board.find(params[:board_id])
    BoardArticle.find_by(article: @article, board: board).destroy

    @article = @article.setup_article_for_feed(current_user)

    turbo_stream
  end

  private

  def boards_params
    params.require(:board).permit(:title, :description)
  end
end