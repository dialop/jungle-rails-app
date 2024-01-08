class ApplicationController < ActionController::Base
  # If you have any filters or protections, you can uncomment or add them here
  # before_action :require_user, except: [:new, :create]
  # protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :cart, :enhanced_cart, :cart_subtotal_cents

  private

  # Method for current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Method to check if user is logged in
  def logged_in?
    !!current_user
  end

  # Methods for handling the cart
  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product: product, quantity: cart[product.id.to_s] } }
  end

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end

  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end
end
