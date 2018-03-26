class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def change_worktime
    @user = User.find(params[:id])
    @user.daily_average_hours = params.fetch("daily_hr").to_i
    
    @user.save
    redirect_back(:fallback_location => "/", :notice => "Average daily hours updated successfully.")
  end
end
