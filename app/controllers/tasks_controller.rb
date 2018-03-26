class TasksController < ApplicationController
  before_action :current_user_must_be_task_user, :only => [:show, :edit, :update, :destroy, :status_toggle]

  def current_user_must_be_task_user
    task = Task.find(params[:id])

    unless current_user == task.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end
  
  def homepage
    @categories = Category.all
    render("tasks/homepage.html.erb")
  end
  
  def index
    
      @tasks = Task.all.where(:user_id => current_user.id)

    render("tasks/index.html.erb")
  end

  def show
    @task = Task.find(params[:id])

    render("tasks/show.html.erb")
  end

  def new
    @task = Task.new
    if URI(request.referer).path == "/categories/new"
    elsif URI(request.referer).path == "/create_category"
    elsif URI(request.referer).path == "/update_task/"+ @task.id.to_s
    elsif URI(request.referer).path == "/tasks/" + "@task.id.to_s" + "/edit"
    else
      session[:previous_url] = request.referrer
    end
    render("tasks/new.html.erb")
  end

  def create
    @task = Task.new

    @task.name = params[:name]
    if Chronic.parse(params[:deadline]) == nil
    elsif Chronic.parse(params[:deadline]) + 5.hours < Time.now
    @task.deadline = Chronic.parse(params[:deadline])
    else
    @task.deadline = Chronic.parse(params[:deadline]) + 5.hours #+ 5.hours accounts for Central Time difference from UTC
    end
    
    @task.status = params[:status]
    @task.user_id = params[:user_id]
    @task.category_id = params[:category_id]

    save_status = @task.save

    if save_status == true
    

      redirect_to(session[:previous_url], :fallback_location => "/", :notice => "Task created successfully.")
    else
      render("tasks/new.html.erb")
    end
  end

  def edit
    @task = Task.find(params[:id])
    if URI(request.referer).path == "/categories/new"
    elsif URI(request.referer).path == "/create_category"
    elsif URI(request.referer).path == "/update_task/"+ @task.id.to_s
    elsif URI(request.referer).path == "/tasks/" + @task.id.to_s + "/edit"
    else
      session[:previous_url] = request.referrer
    end
    render("tasks/edit.html.erb")
  end

  def update
    @task = Task.find(params[:id])

    @task.name = params[:name]
    
    if Chronic.parse(params[:deadline]) == nil
    else
    @task.deadline = Chronic.parse(params[:deadline]) + 5.hours #+ 5.hours accounts for Central Time difference from UTC
    end
    
    @task.status = params[:status]
    @task.user_id = params[:user_id]
    @task.category_id = params[:category_id]

    save_status = @task.save
    if @task.deadline >= Time.now
      @task.status = "incomplete"
      @task.save
    end
    
    
      if Chronic.parse(params[:deadline]) == nil
      redirect_back(:fallback_location => "/", :notice => "Invalid date")
      elsif Chronic.parse(params[:deadline]) + 5.hours < Time.now
      redirect_back(:fallback_location => "/", :notice => "Invalid date")
      elsif params.fetch(:name) == ""
      redirect_back(:fallback_location => "/", :notice => "Name cannot be blank")
      else
      redirect_to(session[:previous_url], :fallback_location => "/", :notice => "Task updated successfully.")
      end
  
  end
  
  
  
  def task_edit_cancel
    redirect_to(session[:previous_url])
  end

  def status_toggle 
    @task = Task.find(params[:id])
   
    if @task.status == "incomplete"
      @task.status = "complete"
      @task.save
      redirect_back(:fallback_location => "/", :notice => "Task marked completed.")
    elsif @task.status == "complete"
      @task.status = "incomplete"
      @task.save
      redirect_back(:fallback_location => "/", :notice => "Task marked incomplete.")
    end
    
    

  end
  def destroy
    @task = Task.find(params[:id])

    @task.destroy

    if URI(request.referer).path == "/tasks/#{@task.id}"
      redirect_to("/", :notice => "Task deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Task deleted.")
    end
  end
end
