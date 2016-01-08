class TestAjaxController < ApplicationController
    def index
        @departments = Department.all
    end
    
    def new
        @department = Department.new
    end
    
    def create
      @department = Department.create department_params
      @departments = Department.all
    end
    
    def department_params
      params.require(:department).permit(:name)
    end
end