class ProductsMailer < ApplicationMailer
    def notify_product_owner(product)
        @product = product
        @owner = product.user
        @review = product.reviews
        mail(to: @owner.email, subject: "You created a new product!")
    end
end
