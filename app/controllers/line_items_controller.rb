class LineItemsController < ApplicationController
  # POST /line_items
  def create

    # Encuentra el producto usando el ID de los parámetros
    product = Product.find(params[:product_id])

    # Encuentra o crea el carrito del usuario
    cart = Cart.where(status: "En proceso", user_id: current_user.id).first
    if cart == nil
      cart = Cart.new(user_id: current_user.id)
      cart.save
    end


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
  # def update
  #   @line_item = LineItem.find(params[:id])

  #   if @line_item.update(line_item_params)
  #     if current_cart.present? && current_cart.id.present?
  #       redirect_to cart_path(current_cart), notice: 'Item was successfully updated.'
  #     else
  #       flash[:alert] = "Cart not found."
  #       redirect_to root_path  # O a una página adecuada en caso de que no haya un carrito
  #     end
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  def update
    @line_item = LineItem.find_by(id: params[:id])  # Cambié `find` por `find_by` para manejar el caso de `nil`

    if @line_item.nil?
      flash[:alert] = "Line item not found."
      redirect_to cart_path(current_user.cart)  # O la ruta que consideres adecuada
      return
    end


    if @line_item.update(line_item_params)
      if current_user.cart.present?
        redirect_to cart_path(@current_cart), notice: 'Item was successfully updated.'
      else
        flash[:alert] = "Cart not found."
        redirect_to root_path  # O una página apropiada en caso de que no haya un carrito
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end


  # DELETE /line_items/:id
  def destroy
    @line_item = LineItem.find_by(id: params[:id])
    @line_item.destroy
    redirect_to cart_path(@current_cart), notice: 'Item was successfully removed.'
    #redirect_to cart_path(line_item.cart)
  end

  private

  # Only allow a list of trusted parameters through.
  def line_item_params
    params.require(:line_item).permit(:quantity, :price)
  end

end
