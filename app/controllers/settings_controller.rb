class SettingsController < ApplicationController

  def edit
    @setting = Setting.instance
  end

  def update
    @setting = Setting.instance

    if @setting.update_attributes(params[:setting])
      flash[:notice] = 'Settings saved!'
    end

    render :action => 'edit'
  end

  def unlock_system
    Setting.toggle_system_locked(false)
    flash[:notice] = 'System unlocked.'
    redirect_to :action => :edit
  end

  def lock_system
    Setting.toggle_system_locked(true)
    flash[:notice] = 'System locked.'
    redirect_to :action => :edit
  end

end
