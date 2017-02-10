class ReviewsController < ApplicationController

  load_resource :book
  load_and_authorize_resource through: :book, only: :create

  def create
    if @review.update_attributes(review_params.to_h)
      redirect_to :back, flash: { success: 'You review will be moderied and added to the list!' }
    else
      byebug
      redirect_to :back, flash: { error: 'Please, check all fields!'}
    end
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
