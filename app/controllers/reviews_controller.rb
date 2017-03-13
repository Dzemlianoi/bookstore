class ReviewsController < ApplicationController
  load_resource :book
  load_and_authorize_resource through: :book, only: :create

  def create
    return render 'books/show' unless @review.update(review_params.merge(user: current_user))
    flash.keep[:success] = t('flashes.success.review_success')
    redirect_to book_path @review.book
  end

  private

  def review_params
    params.require(:review).permit(:name, :comment_text, :rating)
  end
end
