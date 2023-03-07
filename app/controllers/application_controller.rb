class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception

  private

  def cart
    puts "cart"
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    puts "enhanced_cart"
    puts @cart.inspect
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    puts "cart_subtotal_cents"
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents

  def get_order_details(order_id)
    puts "get_order_details"
    LineItem.where(order_id: order_id).map {|item| { product: Product.find_by(id: item.product_id), quantity: item.quantity} }
  end
  helper_method :get_order_details


  def update_cart(new_cart)
    puts "update_cart"
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end
end
