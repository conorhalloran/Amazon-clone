class ProductRemindersJob < ApplicationJob
  queue_as :default

  def perform(product_id)
    product = Product.find product_id
    if product.reviews.count == 0 
    # Do something later
    end
  end
end
