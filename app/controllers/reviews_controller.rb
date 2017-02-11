class ReviewsController < ApplicationController

  load_resource :book
  load_and_authorize_resource through: :book, only: :create

  def create
    if @review.update_attributes(review_params.to_h)
      flash[:success] = t('flashes.success.review_success')
    else
      flash[:error] = t('flashes.error.review_fails')
    end
    redirect_to :back
  end

  private

  def review_params
    params
        .require(:review)
        .permit(:name, :comment_text, :rating)
        .merge(
            user: current_user,
            created_at: Date.today,
            updated_at: Date.today
        )
  end
end
