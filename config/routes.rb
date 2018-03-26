Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "tasks#homepage"
  # Routes for the Category resource:
  # CREATE
  get "/categories/new", :controller => "categories", :action => "new"
  post "/create_category", :controller => "categories", :action => "create"

  # READ
  get "/categories", :controller => "categories", :action => "index"
  get "/categories/:id", :controller => "categories", :action => "show"

  # UPDATE
  get "/categories/:id/edit", :controller => "categories", :action => "edit"
  post "/update_category/:id", :controller => "categories", :action => "update"
  
  # Edit Cancel
  get "/category_edit_cancel", :controller => "categories", :action => "category_edit_cancel"

  # DELETE
  get "/delete_category/:id", :controller => "categories", :action => "destroy"
  #------------------------------

  # Routes for the Task resource:
  # CREATE
  get "/tasks/new", :controller => "tasks", :action => "new"
  post "/create_task", :controller => "tasks", :action => "create"

  # READ
  get "/tasks", :controller => "tasks", :action => "index"
  get "/tasks/:id", :controller => "tasks", :action => "show"

  # UPDATE
  get "/tasks/:id/edit", :controller => "tasks", :action => "edit"
  post "/update_task/:id", :controller => "tasks", :action => "update"
  
   # Toggle Status
  get "/tasks/status_toggle/:id", :controller => "tasks", :action => "status_toggle"
  
   # Edit Cancel
  get "/task_edit_cancel", :controller => "tasks", :action => "task_edit_cancel"

  # DELETE
  get "/delete_task/:id", :controller => "tasks", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"
  post "users/:id/change_worktime", :controller => "users", :action => "change_worktime"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
