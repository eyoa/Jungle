class ReviewsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to product_path(@product.id)
    else
      redirect_to :back
    end

  end
  private
  
  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
