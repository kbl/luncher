class LunchesController < ApplicationController

  def index
    @date = Date.current
    @lunches = Lunch.all 
  end

  def new
    @lunch = Lunch.new
  end

  def edit
    @lunch = Lunch.find(params[:id])
  end

  def create
    @lunch = Lunch.new(params[:lunch])
    if @lunch.save
      flash[:notice] = "Lunch added!"
      redirect_back_or_default lunches_url
    else
      render :action => :new
    end
  end

  def update
    @lunch = Lunch.find(params[:id])
    if @lunch.update_attributes(params[:lunch])
      flash[:notice] = "Lunch info updated!"
      redirect_to lunches_url
    else
      render :action => :index
    end
  end

  def destroy
    lunch = Lunch.find(params[:id])
    if lunch.removable?
      flash[:notice] = "Lunch removed!" if lunch.destroy
    elsif lunch.has_pending_orders?
      flash[:notice] = "There are pending orders for this lunch, it can't be removed"
    else
      flash[:notice] = "Lunch removed!" if lunch.update_attribute(:available, false)
    end
    redirect_to :action => :index
  end

end
