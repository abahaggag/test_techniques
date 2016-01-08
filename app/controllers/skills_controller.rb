class SkillsController < ApplicationController
  def index
    @skills = Skill.all
  end

  def new
    @skill = Skill.new
  end
  
  def create
    @skills = Skill.all
    @skill = Skill.create(skill_params)
  end

  def edit
    @skill = Skill.find_by id: params[:id]
  end
  
  def update
    @skills = Skill.all
    
    @skill = Skill.find_by id: params[:id]
    @skill.update_attributes(skill_params)
  end

  def delete
    @skill = Skill.find_by id: params[:id]
  end
  
  def destroy
    @skills = Skill.all
    @skill = Skill.find_by id: params[:id]
    @skill.destroy
  end
  
  private
  def skill_params
    params.require(:skill).permit(:name)
  end
end
