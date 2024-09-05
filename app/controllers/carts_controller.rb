class CartsController < ApplicationController
  # GET /carts/:id
  before_action :authenticate_user!

  def show
    @cart = Cart.find(params[:id])
  end
  # def show
  #   @cart = current_user.cart # Asegúrate de que current_user.cart devuelva el carrito asociado al usuario actual.
  #   if @cart.nil?
  #     redirect_to products_path, notice: 'No items in cart.'
  #   else
  #     @status = @cart.status # Accede al estado del carrito
  #   end
  # end
