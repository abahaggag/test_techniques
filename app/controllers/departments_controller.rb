class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
  end

  def new
    @department = Department.new
  end
  
  def create
    @departments = Department.all
    @department = Department.create(department_params)
  end

  def edit
    @department = Department.find_by id: params[:id]
  end
  
  def update
    @departments = Department.all
    @department = Department.find_by id: params[:id]
    @department.update_attributes(department_params)
  end

  def delete
    @department = Department.find_by id: params[:id]
  end
  
  def destroy
    @departments = Department.all
    @department = Department.find_by id: params[:id]
    @department.destroy
  end
  
  private
  def department_params
    params.require(:department).permit(:name)
  end
end
