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
    render turbo_stream: turbo_stream.update(
      "dashboard_index",
      partial: "categories/category_details",
      locals: { category: @category }
    )
  end

  private

  def category_params
    params.require(:category).permit(:name, :user_id)
  end
end
