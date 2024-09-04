class LineItemsController < ApplicationController
  # POST /line_items
  def create

    @line_item = LineItem.new
    @product = Product.find(params[:product_id])
    @user = current_user
    Cart.create(user_id: current_user.id) if @user.carts.empty?

    @cart = current_user.carts.first
    @line_item.cart = @cart

    if @line_item.save
      redirect_to cart_path(@cart), notice: 'Product was added'
    else
      render "products/show", status: :unprocessable_entity
    end
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
