class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["BASIC_LOGIN"], password: ENV["BASIC_PASS"]
  def show
    @total_products = Product.count
    @total_categories = Category.count
  end
end
