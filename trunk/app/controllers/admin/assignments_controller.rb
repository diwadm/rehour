class Admin::AssignmentsController < ApplicationController
  layout 'admin'
  
  def index
    @projects = Project.active
    @users = User.active
  end
  
  def new
    @project_assignment = ProjectAssignment.new
  end
  
  def edit
    @project_assignment = ProjectAssignment.find(params[:id])
  end
  
  def show
    @project_assignment = ProjectAssignment.find(params[:id])
  end
  
  def destroy
    @project_assignment = ProjectAssignment.find(params[:id])
    @project_assignment.destroy
    flash[:notice] = 'Assignment has been deleted successfully.'
    redirect_to :action => 'index'
  end
  
  def create
    @project_assignment = ProjectAssignment.new(params[:project_assignment])
    
    if @project_assignment.save
      flash[:notice] = 'Assignment was added successfully.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end
  
  def update
    @project_assignment = ProjectAssignment.find(params[:id])
    
    if @project_assignment.update_attributes(params[:project_assignment])
      flash[:notice] = 'Assignment was updated successfully.'
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
end
