class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :fetch_user, :only => [:show, :edit, :update]

  def index
    @users = User.ordered_by_last_name
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_to account_url
    else
      render :action => :new
    end
  end
  
  def show
    # redirect to /account if non-admin user tries to access others
    # Can't do this with lockdown as /account doesn't provide :id
    unless current_user.is_admin? or @user.id == current_user.id
      redirect_to account_url
    end
    store_location
  end

  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      respond_to do |format|
        format.html { redirect_back_or_default account_url }
        format.js
      end
    else
      render :action => :edit
    end
  end

  def destroy
    if current_user.is_admin?
      user = User.find(params[:id])
      user.destroy
      flash[:notice] = "User #{user.login} deleted!"
    end
    redirect_to users_path
  end

  private

  def fetch_user
    if params[:id]
        @user = User.find(params[:id])
    else
      @user = current_user # makes our views "cleaner" and more consistent
    end
  end

end
