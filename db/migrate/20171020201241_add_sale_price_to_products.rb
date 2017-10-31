class AddSalePriceToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :sale_price, :integer
  end
end
