class ReviewsController < ApplicationController

  load_resource :book
  load_and_authorize_resource through: :book, only: :create

  def create
    @review.update_attributes(review_params.to_h)
  end

  private

  def review_params
    params
        .require(:review)
        .permit(:name, :comment_text, :rating)
        .merge(user: current_user)
  end
end
