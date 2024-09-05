class SetCartDefaultStatus < ActiveRecord::Migration[7.1]
  def change
    change_column_default :carts, :status, "En proceso"
  end
end
