class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        review = Review.find params[:review_id]
        like = Like.new(user: current_user, review: review)
        like.review = review
        like.user = current_user
        if like.save
            redirect_to like.review.product, notice: "Thanks for liking!"
        else
            redirect_to like.review.product, alert: "Can't like! Liked already?"
        end
    end

    def destroy
        review = Campaign.find params[:review_id]
        like = current_user.likes.find params[:id]
        like.destroy
        redirect_to review_path(review), notice: "Like removed!"
    end
end
