class LunchesController < ApplicationController

  before_filter :require_admin, :except => :find_by_date
  before_filter :require_user, :only => :find_by_date

  def index
    @date = Date.current
    @lunches = Lunch.find_all_by_date_or_dateless(@date, true)
  end

  def find_by_date_or_dateless
    @date = Date.civil(params[:year].to_i,
                       params[:month].to_i,
                       params[:day].to_i)
    @lunches = Lunch.find_all_by_date_or_dateless(@date, params[:includ_dateless])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show_by_date_or_dateless
    @date = Date.civil(params[:year].to_i,
                       params[:month].to_i,
                       params[:day].to_i)
    @lunches = Lunch.find_all_by_date_or_dateless(@date, params[:include_dateless])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @lunch = Lunch.new(:name => Lunch.first_available_name_for_date(Date.current))
  end

  def edit
    @lunch = Lunch.find(params[:id])
  end

  def create
    @lunch = Lunch.new(params[:lunch])
    if params[:dateless]
      @lunch.date = nil
    end
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
    lunch.destroy
    flash[:notice] = "Lunch removed!"
    redirect_to :action => :index
  end

end
