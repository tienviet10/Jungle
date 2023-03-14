class Admin::DashboardController < ApplicationController
  before_action :authenticate, only: [:show]
  
  def show
    @product_count = Product.count
    # @category_count = Product.distinct.count(:category_id)
    @category_count = Category.count()
  end

end
