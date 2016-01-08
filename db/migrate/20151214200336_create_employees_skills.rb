class CreateEmployeesSkills < ActiveRecord::Migration
  def change
    create_table :employees_skills, id: false do |t|
      t.integer :employee_id
      t.integer :skill_id
    end
    
    add_index :employees_skills, [:employee_id, :skill_id]
  end
  
end
