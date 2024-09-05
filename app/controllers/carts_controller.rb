class CartsController < ApplicationController
  # GET /carts/:id
  before_action :authenticate_user!

  def show
    @cart = Cart.find(params[:id])
  end
end
