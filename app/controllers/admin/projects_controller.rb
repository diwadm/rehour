class Admin::ProjectsController < ApplicationController
  before_filter :authorize
  layout 'admin'
  
  active_scaffold :project do |config|
    config.list.columns = [:name, :customer, :project_code, :default_project, :active]
    
    columns_for_create_update = [:name, :customer_id, :description, :contact, :project_code, :is_default, :is_active, :is_billable]
    config.create.columns = columns_for_create_update
    config.update.columns = columns_for_create_update
    
    config.columns[:customer_id].label = "Customer"
  end
end
