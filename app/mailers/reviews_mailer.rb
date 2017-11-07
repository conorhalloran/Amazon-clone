class ReviewsMailer < ApplicationMailer

    def notify_product_creator(review)
        @review = review
        @product = review.product
        @reviewer = review.user
        @creator = @product.user
        mail(to: @creator.email, subject: "You have a New Review!")
    end

end
