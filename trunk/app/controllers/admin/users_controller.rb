class Admin::UsersController < ApplicationController
  before_filter :authorize
  layout 'admin'
  
  active_scaffold :user do |config|
    config.list.columns = [:login, :first_name, :last_name, :email, :active]
    
    columns_for_create_update = [:login, :first_name, :last_name, :email, :department_id, :is_active, :password, :password_confirmation, :user_to_user_roles]
    config.create.columns = columns_for_create_update
    config.update.columns = columns_for_create_update
    
    config.columns[:department_id].label = 'Department'
  end
end
