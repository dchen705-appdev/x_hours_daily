class CategoriesController < ApplicationController
  before_action :current_user_must_be_category_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_category_user
    category = Category.find(params[:id])

    unless current_user == category.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = current_user.categories.ransack(params[:q])
      @categories = @q.result(:distinct => true).includes(:user, :tasks).page(params[:page]).per(10)

    render("categories/index.html.erb")
  end

  def show
    @task = Task.new
    @category = Category.find(params[:id])

    render("categories/show.html.erb")
  end

  def new
    @category = Category.new
    session[:previous_url_2] = request.referrer
    render("categories/new.html.erb")
  end

  def create
    @category = Category.new

    @category.name = params[:name]
    @category.user_id = params[:user_id]

    save_status = @category.save

    if save_status == true
    
      redirect_to(session[:previous_url_2], :fallback_location => "/", :notice => "Category updated successfully.")  
    else
      render("categories/new.html.erb")
    end
  end

  def edit
    @category = Category.find(params[:id])
    session[:previous_url_2] = request.referrer
    render("categories/edit.html.erb")
  end

  def update
    @category = Category.find(params[:id])

    @category.name = params[:name]
    @category.user_id = params[:user_id]

    save_status = @category.save

    if save_status == true

        # redirect_to(:back, :fallback_location => "/", :notice => "Category updated successfully.")
    redirect_to(session[:previous_url_2], :fallback_location => "/", :notice => "Category updated successfully.")
    else
      render("categories/edit.html.erb")
    end
  end
  def category_edit_cancel
  redirect_to(session[:previous_url_2])
  end
  def destroy
    @category = Category.find(params[:id])

    @category.destroy

    if URI(request.referer).path == "/categories/#{@category.id}"
      redirect_to("/", :notice => "Category deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Category deleted.")
    end
  end
end
