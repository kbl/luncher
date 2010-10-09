class OrdersController < ApplicationController

  def index
    @orders = Order.ordered_by_vendor_name.group_by { |o| o.lunch.vendor.name }
    @orders.each {|vendor,order_list| order_list.sort! {|x,y| x.lunch.name <=> y.lunch.name}}
  end

  def my
    @orders = Order.by_user(current_user).ordered_by_lunch_name
  end

  def new
    @order = Order.new
    flash[:notice] = "We're sorry, system is locked." if Setting.instance.system_locked
  end

  def create
    order = Order.new(params[:order])
    
    order.user_id = current_user.id
    order.total = order.lunch.price
    if order.save
      flash[:notice] = "Lunch ordered!"
      redirect_to :action => :my
    else
      flash[:notice] = "We're sorry, system is locked."
      redirect_to :action => :new
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    flash[:notice] = "Order removed!"
    if current_user_is_admin?
      redirect_to :action => :index
    else
      redirect_to :action => :my
    end
  end

end
