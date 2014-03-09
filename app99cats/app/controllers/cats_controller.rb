class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new, :status => 422
    end
  end

  def show
    @cat = Cat.find(params[:id])
    @catrental = CatRentalRequest.requests_for_cat_id(Cat.find(params[:id]))
    render :show
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new, :status => 422
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :age, :sex, :color, :birth_date)
  end
end
