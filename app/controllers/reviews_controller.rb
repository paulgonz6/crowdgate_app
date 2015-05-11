class ReviewsController < ApplicationController
  before_action :set_tailgate, :only => [:create, :new]

  def new
    @review = Review.new(:tailgate => @tailgate)
    @rating=  { 1 => 1,
                2 => 2,
                3 => 3,
                4 => 4,
                5 => 5
              }
  end

  def create
    @review = Review.new(review_params)
    @review.tailgate = @tailgate

    if @review.save
      flash[:success] = "Thank you for writing a review about #{@tailgate.name}. See other tailgates from this host below."
      redirect_to user_url(@tailgate.host)
    else
      render 'new'
    end
  end

  private
    def review_params
      params.require(:review).permit(:review, :rating, :user_id, :tailgate_id)
    end

    def set_tailgate
      @tailgate = Tailgate.find(params[:tailgate_id])
    end

end
