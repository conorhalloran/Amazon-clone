class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        review = Review.find params[:review_id]
        like = Like.new(user: current_user, review: review)
        like.review = review
        like.user = current_user
        if !can? :like, review
            head :unauthorized
        elsif like.save
            redirect_to like.review.product, notice: "Thanks for liking!"
        else
            redirect_to like.review.product, alert: "Can't like! Liked already?"
        end
    end

    def destroy
        like = Like.find params[:id]
        if can? :destroy, like
            like.destroy
            redirect_to like.review.product, notice: "Like removed!"
        else
            head :unauthorized
        end
    end
end
