require 'will_paginate/array'

class EmployeesController < ApplicationController
  def index
    #@employees = params[:employee] ? apply_filter : clear_filter_and_return_all_employees

    @employees = Employee.all.paginate(page: params[:page] || 1, per_page: params[:per_page] || 3)
    @departments = Department.all
  end
  
  def show
    @employee = Employee.find_by(id: params[:id])
  end
  
  def new
    @employee = Employee.new
    @departments = Department.all.map { |dept| [dept.name, dept.id] }
  end
  
  def create
    @employee = Employee.new(employee_params)
    
    checked_skills = params[:skills_list] || []
    checked_skills.each do |skill_id|
      @employee.skills << Skill.find(skill_id)  
    end
    
    if @employee.save
        flash[:notice] = 'Employee added successfully.'
        redirect_to action: 'index'
    else
        
        @departments = Department.all.map { |dept| [dept.name, dept.id] }
        render 'new'
    end
    
  end
  
  def edit
    @employee = Employee.find_by(id: params[:id])
    @departments = Department.all.map{ |dept| [dept.name, dept.id] }
  end
  
  def update
    @employee = Employee.find_by(id: params[:id])
    
    skills = Skill.all
    checked_skills = add_and_return_checked_skills
    delete_missing_skills(skills, checked_skills)
    
    if @employee.update_attributes(employee_params) 
      flash[:notice] = 'Employee updated successfully.'
      redirect_to action: 'index'
    else
      @departments = Department.all.map{ |dept| [dept.name, dept.id] }
      render 'edit'
    end
    
  end
  
  def delete
    @employee = Employee.find_by(id: params[:id])
  end
  
  def destroy
    @employee = Employee.find_by(id: params[:id])
    
    if @employee.destroy
        flash[:notice] = "Employee deleted successfully."
        redirect_to action: 'index'
    else
        render 'delete'
    end
    
  end
  
  def search
      @employees = apply_filter.paginate(page: params[:page] || 1, per_page: params[:per_page] || 100)
      @departments = Department.all
      render 'index'
      
  end
  
  private
  def employee_params
    params.require(:employee).permit(:name, :gender, :department_id, :birth_date, :salary)
  end
  
  def add_and_return_checked_skills
        
      checked_skills = []
  
      checked_params = params[:skills_list] || []
      for check_box_id in checked_params
          skill = Skill.find_by(id: check_box_id)
          if not @employee.skills.include?(skill)
              @employee.skills << skill
          end
          checked_skills << skill
      end
      return checked_skills
  end
    
  def delete_missing_skills(skills, checked_skills)
    missing_skills = skills - checked_skills
  
    for skill in missing_skills
        if @employee.skills.include?(skill)
            @employee.skills.delete(skill)
        end
    end    
  end
  
  def apply_filter
    query_array = []
    
    if params[:name] != ""
      query_array << "name like '%#{params[:name]}%'"
    end
    
    if params[:department_id] != ""
        query_array << "department_id = #{params[:department_id]}"
    end
    
    if params[:gender] && params[:gender] != "All"
        query_array << "gender = #{params[:gender] == "Male" ? 1 : 0}"
    end
    
    if params[:salary] != ""
        query_array << "salary = #{params[:salary]}"
    end
    
    if query_array.size == 0
        employees = Employee.all
    elsif query_array.size == 1
        employees = Employee.where(query_array[0])
    elsif query_array.size > 1
        employees = Employee.where(query_array.join(" AND "))
    end
    
    if params[:skills]
        employees = employees.select do |emp|
          params[:skills].any? { |param_skill| (emp.skills.map{|emp_skill| emp_skill.id}).include?(param_skill.to_i) }
        end
    end
    
    return employees
  end
  
  def clear_filter_and_return_all_employees
    params[:employee] = []
    Employee.all
  end
end
