class ReviewsController < ApplicationController
  load_resource :book
  load_and_authorize_resource through: :book, only: :create

  def create
    if @review.update(review_params.merge(user: current_user))
      flash[:success] = t('flashes.success.review_success')
    else
      flash[:alert] = t('flashes.error.review_fails')
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.require(:review).permit(:name, :comment_text, :rating)
  end
end
