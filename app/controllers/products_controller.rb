class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
    current_user
  end

  def show
    @product = Product.find params[:id]
  end

end
