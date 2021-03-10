class ReviewsController < ApplicationController
  before_filter :authorize

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
  
  def destroy
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    @review.destroy
    
    redirect_to product_path(@product.id)
  end
  
  private
  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
