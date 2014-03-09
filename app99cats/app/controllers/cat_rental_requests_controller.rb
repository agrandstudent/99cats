class CatRentalRequestsController < ApplicationController
  def index
    @cats = Cat.all
    @rentalrequests = CatRentalRequest.all
    @rentalrequests.
    render :index
  end

  def new
    @catrental = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @cats = Cat.all
    @catrental = CatRentalRequest.new(cat_rental_params)
    if @catrental.save
      redirect_to cat_rental_request_url(@catrental)
    else
      flash.now[:errors] = @catrental.errors.full_messages
      render :new, :status => 422
    end
  end

  def show
    @catrental = CatRentalRequest.find(params[:id])
    render :show
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to cat_rental_requests_url
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to cat_rental_requests_url
  end

  private
  def cat_rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
