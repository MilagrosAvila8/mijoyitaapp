class LineItemsController < ApplicationController
  # POST /line_items
  def create

    # Encuentra el producto usando el ID de los parámetros
    product = Product.find(params[:product_id])

    # Encuentra o crea el carrito del usuario
    cart = current_user.cart || Cart.create(user: current_user)

    # Encuentra o crea el LineItem para el producto en el carrito
    line_item = cart.line_items.find_or_initialize_by(product: product)

    # Asegúrate de que quantity esté inicializado a 0 si es nil
    line_item.quantity ||= 0
    line_item.quantity += params[:quantity].to_i

    # Asigna el precio del producto
    line_item.price = product.price

    # Guarda el LineItem
    line_item.save

    # Redirige o responde según tus necesidades
    redirect_to cart_path(cart), notice: 'Producto añadido al carrito'
    # @line_item = LineItem.new
    # @product = Product.find(params[:product_id])
    # @user = current_user
    # Cart.create(user_id: current_user.id) if @user.carts.empty?

    # @cart = current_user.carts.first
    # @line_item.cart = @cart

    # if @line_item.save
    #   redirect_to cart_path(@cart), notice: 'Product was added'
    # else
    #   render "products/show", status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /line_items/:id
  def update
    @line_item = LineItem.find(params[:id])
    if @line_item.update(line_item_params)
      redirect_to @line_item, notice: 'Product was updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /line_items/:id
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to lineItems_url, notice: 'Product was destroyed.'
  end

  private

  # Only allow a list of trusted parameters through.
  def line_item_params
    params.require(:line_item).permit(:cart_id, :product_id, :quantity, :price)
  end

end
