class VendorsController < ApplicationController
  before_filter :require_admin

  def new
    @vendor = Vendor.new
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def index
    @vendors = Vendor.all
  end

  def create
    vendor = Vendor.new(params[:vendor])
    flash[:notice] = "Vendor added!" if vendor.save
    redirect_to vendors_url 
  end

  def update
    vendor = Vendor.find(params[:id])
    flash[:notice] = "Vendor info updated!" if vendor.update_attributes(params[:vendor])
    redirect_to vendors_url 
  end

  def destroy
    vendor = Vendor.find(params[:id])
    flash[:notice] = "Vendor removed!" if vendor.destroy
    redirect_to vendors_url 
  end
end
