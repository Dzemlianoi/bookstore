class ReviewsController < ApplicationController
  load_resource :book
  load_and_authorize_resource through: :book, only: :create

  def create
    @reviews = @book.reviews.approved.decorate
    @review.skip_field_error_wrapper = true
    render 'books/show' and return unless @review.update(review_params.merge(user: current_user))
    flash.keep[:success] = t('flashes.success.review_success')
    redirect_to @review.book
  end

  private

  def review_params
    params.require(:review).permit(:name, :comment_text, :rating)
  end
end
