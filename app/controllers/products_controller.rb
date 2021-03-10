class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]

    if @product.reviews
      @avg_rating = @product.reviews.average(:rating).round(1)
    else
      @avg_rating = 'no reviews' 
    end
  end

end
