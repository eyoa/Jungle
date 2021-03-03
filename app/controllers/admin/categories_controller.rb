class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV["BASIC_LOGIN"], password: ENV["BASIC_PASS"]

  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
