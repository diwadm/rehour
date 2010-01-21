class Admin::CustomersController < ApplicationController
  before_filter :authorize
  layout 'admin'
  
  active_scaffold :customer do |config|
    config.list.columns = [:name, :code, :description, :active]
    
    columns_for_create_update = [:name, :code, :description, :is_active]
    config.create.columns = columns_for_create_update
    config.update.columns = columns_for_create_update
  end
end
