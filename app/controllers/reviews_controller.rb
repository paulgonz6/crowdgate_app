class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @rating=  { 1 => 1,
                2 => 2,
                3 => 3,
                4 => 4,
                5 => 5
              }
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = "Thank you for writing a review about #{Tailgate.find(@review.tailgate_id).name}!"
      redirect_to user_url(@review.user_id)
    else
      render 'new'
    end
  end

  private
    def review_params
      params.require(:review).permit(:review, :rating, :user_id, :tailgate_id)
    end

end
