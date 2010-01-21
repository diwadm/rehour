class Admin::DepartmentsController < ApplicationController
  before_filter :authorize
  layout 'admin'
  
  active_scaffold :department do |config|
    config.columns = [:name, :code]
    config.nested.add_link("Users", [:users])
  end
end
